import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:share_space/data/local/token_storage.dart';
import 'package:share_space/data/local/token_storage_impl.dart';
import 'package:share_space/data/remote/auth_api_service.dart';
import 'package:share_space/data/remote/booking_api_service_impl.dart';
import 'package:share_space/data/remote/location_service.dart';
import 'package:share_space/data/remote/location_service_impl.dart';
import 'package:share_space/data/remote/user_api_service.dart';
import 'package:share_space/data/remote/user_api_service_impl.dart';
import 'package:share_space/data/repository/authentication_repository_impl.dart';
import 'package:share_space/data/repository/room_details_repository_impl.dart';
import 'package:share_space/data/repository/user_repository_impl.dart';
import 'package:share_space/data/repository/workspace_repository_impl.dart';
import 'package:share_space/domain/repository/UserRepository.dart';
import 'package:share_space/domain/repository/authentication_repository.dart';
import 'package:share_space/domain/repository/room_details_repository.dart';
import 'package:share_space/domain/repository/workspace_repository.dart';
import 'package:share_space/domain/usecase/User/getUserDetailsUseCase.dart';
import 'package:share_space/domain/usecase/User/getUserLocationUseCase.dart';
import 'package:share_space/domain/usecase/authentication/login_usecase.dart';
import 'package:share_space/domain/usecase/booking/book_room.dart';
import 'package:share_space/domain/usecase/booking/get_booking_history.dart';
import 'package:share_space/domain/usecase/room_details/get_room_details.dart';
import 'package:share_space/domain/usecase/workspace/get_best.dart';
import 'package:share_space/domain/usecase/workspace/get_best_price.dart';
import 'package:share_space/domain/usecase/workspace/get_featured.dart';
import 'package:share_space/domain/usecase/workspace/get_near_to_you.dart';
import 'package:share_space/domain/usecase/workspace/get_popular.dart';
import 'package:share_space/domain/usecase/workspace/get_top_rated.dart';
import 'package:share_space/presentation/screen/booking_history/state/booking_history_cubit.dart';
import 'package:share_space/presentation/screen/home/state/home_cubit.dart';
import 'package:share_space/presentation/screen/login/state/login_cubit.dart';

import '../data/remote/auth_api_service_impl.dart';
import '../data/remote/booking_api_service.dart';
import '../data/remote/dio_client.dart';
import '../data/remote/workspace_api_service.dart';
import '../data/remote/workspace_api_service_impl.dart';
import '../data/repository/booking_repository_impl.dart';
import '../domain/repository/booking_repository.dart';
import '../domain/usecase/authentication/create_account_usecase.dart';
import '../domain/usecase/authentication/is_loggedIn_usecase.dart';
import '../domain/usecase/authentication/logout_usecase.dart';
import '../presentation/screen/my_account/cubit/my_account_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorageImpl());

  getIt.registerLazySingleton<Dio>(() {
    DioClient(getIt<TokenStorage>());
    return DioClient.instance;
  });

  getIt.registerLazySingleton<WorkspaceApiService>(
    () => WorkspaceApiServiceImpl(getIt()),
  );

  getIt.registerLazySingleton<WorkspaceRepository>(
    () => WorkspaceRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<BookingApiService>(
        () => BookingApiServiceImpl(getIt()),
  );

  getIt.registerLazySingleton<BookingRepository>(
        () => BookingRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(getIt(),getIt()),
  );



  getIt.registerLazySingleton(() => GetBestUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBestPriceUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPopularUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNearToYouUseCase(getIt()));
  getIt.registerLazySingleton(() => GetTopRatedUseCase(getIt()));
  getIt.registerLazySingleton(() => GetFeaturedUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUserDetailsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentLocationUseCase(getIt()));

  getIt.registerLazySingleton(() => GetBookingHistoryUseCase(getIt()));
  getIt.registerLazySingleton(() => BookRoomUseCase(getIt()));


  getIt.registerFactory(
    () => HomeCubit(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton<RoomDetailsRepository>(
    () => RoomDetailsRepositoryImpl(getIt()),
  );

  getIt.registerFactory(() => GetRoomDetailsUseCase(getIt()));

  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiServiceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<LocationService>(
        () => LocationServiceImpl(),
  );
  getIt.registerLazySingleton<UserApiService>(
        () => UserApiServiceImpl(getIt()),
  );

  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => IsLoggedInUseCase(getIt()));

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(getIt()),
  );

  getIt.registerFactory(() => LoginCubit(getIt()));

  getIt.registerFactory(() => BookingHistoryCubit(getIt()));

  getIt.registerFactory<CreateAccountUseCase>(
    () => CreateAccountUseCase(getIt()),
  );

  getIt.registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(getIt<AuthenticationRepository>()),
  );

  getIt.registerFactory<MyAccountCubit>(
        () => MyAccountCubit(
      getIt<GetUserDetailsUseCase>(),
      getIt<LogoutUseCase>(),
    ),
  );
}
