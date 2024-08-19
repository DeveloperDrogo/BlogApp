import 'package:clean/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updateDateTime,
    super.posterName
  });

  Map<String, dynamic> toJson() { //converting to toMap to toJson
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updateDateTime.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id']??'',
      title: map['title'] ??'',
      content: map['content'] ??'',
      imageUrl: map['image_url'] ??'',
      topics: List<String>.from(map['topics'] ?? []),
      updateDateTime: map['updated_at'] == null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
    );
  }

 




  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updateDateTime,
    String ? posterName
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updateDateTime: updateDateTime ?? this.updateDateTime,
      posterName: posterName?? this.posterName
    );
  }
}
