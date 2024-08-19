import 'dart:io';

import 'package:clean/core/error/exception.dart';
import 'package:clean/core/error/failure.dart';
import 'package:clean/core/network/connection_checker.dart';
import 'package:clean/features/blog/data/datasource/blog_local_data_source.dart';
import 'package:clean/features/blog/data/datasource/blog_remote_data_source.dart';
import 'package:clean/features/blog/data/model/blog_model.dart';
import 'package:clean/features/blog/domain/entities/blog.dart';
import 'package:clean/features/blog/domain/repository/blog_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Blog>> uploadIBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {

      if(!await (connectionChecker.isConnected)){
        return left(Failure('No Internet Connection'));
      }
      // Create the initial BlogModel with an empty imageUrl
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updateDateTime: DateTime.now(),
      );

      // Upload the image and get the image URL
      final imageUrlGet = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      // Update the blogModel with the new image URL
      blogModel = blogModel.copyWith(imageUrl: imageUrlGet);

      // Upload the blog with the updated image URL
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlog() async {
    try {
      if(!await (connectionChecker.isConnected)){
       final blogs =  blogLocalDataSource.loadBlogs();
       return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
