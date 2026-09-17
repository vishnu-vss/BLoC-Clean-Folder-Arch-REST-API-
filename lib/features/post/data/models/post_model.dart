import 'package:bloc_clean_arch_with_rest_api/features/post/domain/entities/post_entities.dart';

class PostModel extends PostEntities {
  const PostModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }

  factory fromEntity(PostEntities entity) {
    return PostModel(
      userId: entity.userId,
      id: entity.id,
      title: entity.title,
      body: entity.body,
    );
  }
}
