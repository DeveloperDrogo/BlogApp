import 'dart:io';

import 'package:clean/core/error/failure.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/features/blog/domain/entities/blog.dart';
import 'package:clean/features/blog/domain/repository/blog_repo.dart';
import 'package:fpdart/fpdart.dart';


class UploadBlogUsecase implements UseCase<Blog, UploadBlogParms> {
  final BlogRepository blogRepository;
  UploadBlogUsecase(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParms parms) async {
    return await blogRepository.uploadIBlog(
      image: parms.image,
      title: parms.title,
      content: parms.content,
      posterId: parms.posterId,
      topics: parms.topics,
    );
  }
}

class UploadBlogParms {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  UploadBlogParms({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}
