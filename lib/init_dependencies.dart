import 'package:clean/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean/core/network/connection_checker.dart';
import 'package:clean/core/secrets/app_secrets.dart';
import 'package:clean/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:clean/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:clean/features/auth/domain/usecase/current_user.dart';
import 'package:clean/features/auth/domain/usecase/user_login.dart';
import 'package:clean/features/auth/domain/usecase/user_sign_up.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean/features/blog/data/datasource/blog_local_data_source.dart';
import 'package:clean/features/blog/data/datasource/blog_remote_data_source.dart';
import 'package:clean/features/blog/data/repository/blog_repo_impl.dart';
import 'package:clean/features/blog/domain/repository/blog_repo.dart';
import 'package:clean/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:clean/features/blog/domain/usecase/upload_blog.dart';
import 'package:clean/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name:'blogs'));

  serviceLocator.registerLazySingleton(() => supabase.client);

//core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory(
    () => InternetConnection(),
  );

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  //data
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoateDataSourceImpl(
      serviceLocator(),
    ),
  );
//repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthoRepositoryImpl(
      serviceLocator(),
      serviceLocator(),
    ),
  );

//usecase
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
//usecase
  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );
//login check
  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );

//bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  //datasource
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
       serviceLocator(),
    ),
  );

    serviceLocator.registerFactory<BlogLocalDataSource>(
    () => BlogLocalDataSourceImpl(
      serviceLocator(),
    ),
  );

//repository
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator()
    ),
  );

//usecase
  serviceLocator.registerFactory(
    () => UploadBlogUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetAllBlogs(
      serviceLocator(),
    ),
  );

//bloc
  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadBlogUsecase: serviceLocator(),
      getAllBlogs: serviceLocator(),
    ),
  );
}
