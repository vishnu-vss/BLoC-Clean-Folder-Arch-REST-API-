part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  final List<PostEntities> posts;
  const PostState({required this.posts});

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {
  const PostInitial() : super(posts: const []);
}

final class PostLoading extends PostState {
  const PostLoading({required super.posts});
}

final class PostLoaded extends PostState {
  const PostLoaded({required super.posts});

  @override
  List<Object> get props => [posts];
}

final class PostError extends PostState {
  final String message;

  const PostError({required super.posts, required this.message});

  @override
  List<Object> get props => [posts, message];
}
