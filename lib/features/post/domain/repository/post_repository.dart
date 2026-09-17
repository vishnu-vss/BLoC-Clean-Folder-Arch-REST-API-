import 'package:bloc_clean_arch_with_rest_api/features/post/domain/entities/post_entities.dart';

import 'package:fpdart/fpdart.dart';

abstract class PostRepository {
  // GET POSTS
  Future<Either<Exception, List<PostEntities>>> getPosts();

  // CREATE POST
  Future<Either<Exception, PostEntities>> createPost(PostEntities post);
}
