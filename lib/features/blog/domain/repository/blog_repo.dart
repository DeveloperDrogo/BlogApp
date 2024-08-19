import 'dart:io';

import 'package:clean/core/error/failure.dart';
import 'package:clean/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository{
  Future<Either<Failure,Blog>> uploadIBlog(
    {
      required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics,
    }
  );

  Future<Either<Failure,List<Blog>>> getAllBlog();
}
