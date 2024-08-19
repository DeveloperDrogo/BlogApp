import 'dart:async';
import 'dart:io';

import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/features/blog/domain/entities/blog.dart';
import 'package:clean/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:clean/features/blog/domain/usecase/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogs _getAllBlogs;
  BlogBloc(
      {required UploadBlogUsecase uploadBlogUsecase,
      required GetAllBlogs getAllBlogs})
      : _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogUpload>(_blogUpload);
    on<BlogFetchAllBlogs>(_blogFetchAllBlogs);
  }

  FutureOr<void> _blogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    final result = await _uploadBlogUsecase(
      UploadBlogParms(
        image: event.image,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );

    result.fold(
      (l) => emit(BlogFailure(failureMsg: l.message)),
      (r) => emit(
        UploadBlogSuccess(),
      ),
    );
  }

  FutureOr<void> _blogFetchAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _getAllBlogs(NoParms());

    result.fold((l) => emit(BlogFailure(failureMsg: l.message)),
        (r) => emit(FetchBlogSuccess(r)));
  }
}
