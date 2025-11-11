import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../local/token_storage.dart';
import 'api_constants.dart';

class DioClient {
  static Dio? _dio;
  static bool _isRefreshing = false;
  static final List<void Function()> _refreshCallbacks = [];
  static TokenStorage? _tokenStorage;
  static bool _isInitialized = false;

  static late CacheOptions cacheOptions;

  DioClient(TokenStorage tokenStorage) {
    _tokenStorage = tokenStorage;
    _initializeDio();
  }

  static Future<void> _initializeCache() async {
    try {
      final dir = await getTemporaryDirectory();
      final cacheStore = HiveCacheStore(dir.path);

      cacheOptions = CacheOptions(
        store: cacheStore,
        policy: CachePolicy.forceCache,
        maxStale: const Duration(days: 30),
        priority: CachePriority.high,
        hitCacheOnErrorExcept: [401, 403],
      );
    } catch (e) {
      debugPrint('Cache initialization failed: $e');

      cacheOptions = CacheOptions(
        store: MemCacheStore(),
        policy: CachePolicy.forceCache,
        maxStale: const Duration(days: 30),
        priority: CachePriority.high,
        hitCacheOnErrorExcept: [401, 403],
      );
    }
  }

  static void _initializeDio() {
    if (_isInitialized) return;

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.apiBaseUrl,
        connectTimeout: const Duration(seconds: 1000),
        receiveTimeout: const Duration(seconds: 1000),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _initializeCache();

    _dio!.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.forceCache,
          maxStale: const Duration(days: 30),
          priority: CachePriority.high,
          hitCacheOnErrorExcept: [401, 403],
        ),
      ),
    );

    _dio!.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );

    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.path.contains('auth/login') ||
              options.path.contains('auth/register')) {
            return handler.next(options);
          }

          final token = await _tokenStorage?.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            debugPrint('Adding token to request: ${options.path}');
          } else {
            debugPrint('No token found for request: ${options.path}');
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            if (error.requestOptions.path.contains('auth/login') ||
                error.requestOptions.path.contains('auth/register') ||
                error.requestOptions.path.contains('auth/refresh')) {
              return handler.next(error);
            }

            try {
              if (_isRefreshing) {
                await _waitForRefresh();
                final response = await _retry(error.requestOptions);
                return handler.resolve(response);
              }

              _isRefreshing = true;
              final newAccessToken = await _refreshToken();

              if (newAccessToken != null) {
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';

                _notifyRefreshCallbacks();

                final response = await _retry(error.requestOptions);
                return handler.resolve(response);
              } else {
                await _tokenStorage?.deleteTokens();
                return handler.next(error);
              }
            } catch (e) {
              debugPrint('Error refreshing token: $e');
              await _tokenStorage?.deleteTokens();
              return handler.next(error);
            } finally {
              _isRefreshing = false;
              _refreshCallbacks.clear();
            }
          }

          return handler.next(error);
        },
      ),
    );

    _isInitialized = true;
  }

  static Dio get instance {
    if (_dio == null || !_isInitialized) {
      throw StateError(
        'DioClient not initialized. Call DioClient(tokenStorage) first.',
      );
    }
    return _dio!;
  }

  static Future<void> _waitForRefresh() async {
    final completer = Completer<void>();
    _refreshCallbacks.add(() => completer.complete());
    return completer.future;
  }

  static void _notifyRefreshCallbacks() {
    for (var callback in _refreshCallbacks) {
      callback();
    }
  }

  static Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return _dio!.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  static Future<String?> _refreshToken() async {
    try {
      final refreshToken = await _tokenStorage?.getRefreshToken();
      if (refreshToken == null) {
        debugPrint('No refresh token available');
        return null;
      }

      debugPrint('Attempting to refresh token...');
      final response = await _dio!.post(
        ApiConstants.refresh,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data['success'] == true) {
        final newAccessToken = response.data['data']['accessToken'];
        final newRefreshToken = response.data['data']['refreshToken'];

        await _tokenStorage?.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        debugPrint('Token refreshed successfully');
        return newAccessToken;
      }
      return null;
    } catch (e) {
      debugPrint('Failed to refresh token: $e');
      return null;
    }
  }

  static Future<void> clearCache() async {
    try {
      await cacheOptions.store?.clean();
      debugPrint('Cache cleared successfully');
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  static void resetInstance() {
    _dio?.close();
    _dio = null;
    _isRefreshing = false;
    _refreshCallbacks.clear();
    _tokenStorage = null;
    _isInitialized = false;
  }
}
