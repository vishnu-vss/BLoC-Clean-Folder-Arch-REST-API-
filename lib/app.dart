import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/networking/dio_client.dart';
import 'core/routes/app_router.dart';

import 'features/post/data/datasource/post_remote_data_source.dart';
import 'features/post/data/repository/post_repository_impl.dart';

import 'features/post/domain/repository/post_repository.dart';
import 'features/post/domain/usecases/get_post_usecase.dart';

import 'features/post/presentation/bloc/post_bloc.dart';

class PracticeBlocWithRest extends StatelessWidget {
  const PracticeBlocWithRest({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
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
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider<PostBloc>(
            create: (context) {
              return PostBloc(getPostUsecase: context.read<GetPostUsecase>());
            },
          ),
        ],

        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Practice BLoC with REST API',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: AppRouter.routes,
        ),
      ),
    );
  }
}
