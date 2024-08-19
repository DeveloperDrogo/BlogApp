import 'package:clean/core/error/failure.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/features/blog/domain/entities/blog.dart';
import 'package:clean/features/blog/domain/repository/blog_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParms> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParms parms) async {
    return await blogRepository.getAllBlog();
  }
}
