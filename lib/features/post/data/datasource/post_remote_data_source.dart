import 'dart:convert';

import 'package:bloc_clean_arch_with_rest_api/core/networking/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<Either<Exception, List<PostModel>>> getPosts();

  Future<Either<Exception, PostModel>> createPost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dioClient;
  PostRemoteDataSourceImpl(this.dioClient);

  @override
  Future<Either<Exception, List<PostModel>>> getPosts() async {
    try {
      final response = await dioClient.get('/posts');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<PostModel> posts = data
            .map((json) => PostModel.fromJson(json))
            .toList();
        return Right(posts);
      } else {
        return Left(Exception('Failed to fetch posts'));
      }
    } on DioException catch (ex) {
      return Left(Exception(ex.message));
    } catch (ex) {
      return Left(Exception(ex.toString()));
    }
  }

  @override
  Future<Either<Exception, PostModel>> createPost(PostModel postModel) async {
    try {
      final response = await dioClient.post(
        '/posts',
        data: jsonEncode(postModel.toJson()),
      );
      if (response.statusCode == 201) {
        final PostModel createdPost = PostModel.fromJson(response.data);
        return Right(createdPost);
      } else {
        return Left(Exception('Failed to create post'));
      }
    } on DioException catch (ex) {
      return Left(Exception(ex.message));
    } catch (ex) {
      return Left(Exception(ex.toString()));
    }
  }
}
