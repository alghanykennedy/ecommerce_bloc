import 'package:dio/dio.dart';
import 'package:ecommerce_bloc/core/network/dio_http.dart';
import 'package:ecommerce_bloc/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerce_bloc/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_bloc/features/auth/domain/usecases/user_sign_up.dart';
import 'package:ecommerce_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // http client
  sl.registerLazySingleton<Dio>(() => DioHttp().setup());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl<Dio>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => UserSignUpUseCase(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(userSignUp: sl()));
}
