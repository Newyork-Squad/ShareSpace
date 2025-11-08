import 'package:get_it/get_it.dart';
import 'package:share_space/data/remote/auth_api_service.dart';
import 'package:share_space/data/repository/authentication_repository_impl.dart';
import 'package:share_space/data/repository/workspace_repository_impl.dart';
import 'package:share_space/domain/repository/authentication_repository.dart';
import 'package:share_space/domain/repository/workspace_repository.dart';
import 'package:share_space/domain/usecase/authentication/login_usecase.dart';
import 'package:share_space/presentation/screen/login/state/login_cubit.dart';

import '../data/remote/dio_client.dart';
import '../data/remote/workspace_api_service.dart';
import '../data/remote/workspace_api_service_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton(() => DioClient.instance);

  getIt.registerLazySingleton<WorkspaceApiService>(
    () => WorkspaceApiServiceImpl(getIt()),
  );

  getIt.registerLazySingleton<WorkspaceRepository>(
    () => WorkspaceRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => AuthApiService(getIt()));

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => LoginUseCase(getIt()));

  getIt.registerFactory(() => LoginCubit(getIt()));
}