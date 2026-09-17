import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/networking/dio_client.dart';
import 'data/datasource/post_remote_data_source.dart';
import 'data/repository/post_repository_impl.dart';
import 'domain/repository/post_repository.dart';
import 'domain/usecases/get_post_usecase.dart';
import 'presentation/bloc/post_bloc.dart';

// Dependency Injection for Post Feature
List initializePostDependencies() {
  return [
    // Dio Client
    RepositoryProvider<DioClient>(create: (context) => DioClient()),

    // Remote Data Source
    RepositoryProvider<PostRemoteDataSource>(
      create: (context) {
        return PostRemoteDataSourceImpl(context.read<DioClient>());
      },
    ),

    // Repository
    RepositoryProvider<PostRepository>(
      create: (context) {
        return PostRepositoryImpl(context.read<PostRemoteDataSource>());
      },
    ),

    // UseCase
    RepositoryProvider<GetPostUsecase>(
      create: (context) {
        return GetPostUsecase(context.read<PostRepository>());
      },
    ),
  ];
}

// Dependency Injection for Post Feature BLoC
List initializePostBlocs() {
  return [
    BlocProvider<PostBloc>(
      create: (context) {
        return PostBloc(getPostUsecase: context.read<GetPostUsecase>());
      },
    ),
  ];
}
