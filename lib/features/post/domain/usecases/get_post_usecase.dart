import 'package:bloc_clean_arch_with_rest_api/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/post_entities.dart';
import '../repository/post_repository.dart';

class GetPostUsecase implements UseCase<List<PostEntities>, NoParams> {
  final PostRepository _postRepository;
  GetPostUsecase(this._postRepository);

  @override
  Future<Either<Exception, List<PostEntities>>> call(NoParams params) {
    return _postRepository.getPosts();
  }
}
