part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String failureMsg;
  BlogFailure({required this.failureMsg});
}

final class UploadBlogSuccess extends BlogState {}

final class FetchBlogSuccess extends BlogState {
  final List<Blog> blogs;

  FetchBlogSuccess(this.blogs);
}
