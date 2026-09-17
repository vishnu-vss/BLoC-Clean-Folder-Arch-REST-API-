part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPostsEvent extends PostEvent {
  const FetchPostsEvent();

  @override
  List<Object> get props => [];
}

class CreatePostEvent extends PostEvent {
  final PostEntities post;
  const CreatePostEvent(this.post);

  @override
  List<Object> get props => [post];
}
