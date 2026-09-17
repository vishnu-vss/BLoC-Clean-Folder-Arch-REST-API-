import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/post_entities.dart';
import '../../domain/usecases/get_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostUsecase _getPostUsecase;

  PostBloc(this._getPostUsecase) : super(PostInitial()) {
    on<FetchPostsEvent>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(
    FetchPostsEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading(posts: [...state.posts]));
    final result = await _getPostUsecase.call(NoParams());
    result.fold(
      (failure) =>
          emit(PostError(message: failure.toString(), posts: [...state.posts])),
      (posts) => emit(PostLoaded(posts: posts)),
    );
  }
}
