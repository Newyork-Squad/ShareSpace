import 'package:get_it/get_it.dart';
import 'package:share_space/data/repository/room_details_repository_impl.dart';
import 'package:share_space/data/repository/workspace_repository_impl.dart';
import 'package:share_space/domain/repository/room_details_repository.dart';
import 'package:share_space/domain/repository/workspace_repository.dart';
import 'package:share_space/domain/usecase/workspace/get_best.dart';
import 'package:share_space/domain/usecase/workspace/get_best_price.dart';
import 'package:share_space/domain/usecase/workspace/get_near_to_you.dart';
import 'package:share_space/domain/usecase/workspace/get_popular.dart';
import 'package:share_space/domain/usecase/workspace/get_top_rated.dart';
import 'package:share_space/presentation/screen/home/state/home_cubit.dart';
import 'package:share_space/domain/usecase/room_details/get_room_details.dart';
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

  getIt.registerLazySingleton(() => GetBestUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBestPriceUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPopularUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNearToYouUseCase(getIt()));
  getIt.registerLazySingleton(() => GetTopRatedUseCase(getIt()));

  getIt.registerFactory(
    () => HomeCubit(
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

  getIt.registerFactory(
    () => GetRoomDetailsUseCase(getIt()),
  );
}
