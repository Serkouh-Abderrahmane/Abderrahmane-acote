import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:serkouhacote/core/network/NetworkInfo.dart';
import 'package:serkouhacote/features/users/data/datasources/profile_remote_data_source.dart';
import 'package:serkouhacote/features/users/data/datasources/user_remote_data_source.dart';
import 'package:serkouhacote/features/users/data/repositories/profile_repository_impl.dart';
import 'package:serkouhacote/features/users/data/repositories/user_repository.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_users.dart';
import 'package:serkouhacote/features/users/presentation/bloc/profile_bloc.dart';
import 'package:serkouhacote/features/users/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Register external dependencies
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity()); // Dependency for NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Register remote data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dio: sl()),
  );

  // Register repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );

  // Register use cases
  sl.registerLazySingleton(() => GetUsers(sl()));

  // Register BLoCs
  sl.registerFactory(
    () => UserBloc(getUsers: sl()),
  );

  sl.registerFactory(
    () => ProfileBloc(repository: sl()),
  );
}
