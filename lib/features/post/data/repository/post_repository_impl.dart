import 'package:bloc_clean_arch_with_rest_api/features/post/domain/entities/post_entities.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repository/post_repository.dart';
import '../datasource/post_remote_data_source.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _postRemoteDataSource;
  PostRepositoryImpl(this._postRemoteDataSource);

  @override
  Future<Either<Exception, PostEntities>> createPost(PostEntities post) {
    try {
      return _postRemoteDataSource.createPost(PostModel.fromEntity(post));
    } on DioException catch (ex) {
      return Future.value(
        Left(Exception('Failed to create post: ${ex.message}')),
      );
    } catch (e) {
      return Future.value(
        Left(Exception('Failed to create post: ${e.toString()}')),
      );
    }
  }

  @override
  Future<Either<Exception, List<PostEntities>>> getPosts() {
    try {
      return _postRemoteDataSource.getPosts();
    } on DioException catch (ex) {
      return Future.value(
        Left(Exception('Failed to fetch posts: ${ex.message}')),
      );
    } catch (e) {
      return Future.value(
        Left(Exception('Failed to fetch posts: ${e.toString()}')),
      );
    }
  }
}
