import 'package:mynul_test/src/models/PostModel.dart';
import 'package:mynul_test/src/repository/api/network/NetworkApiServices.dart';

class PostsApiService {
  final _baseUrl = 'https://jsonplaceholder.typicode.com';
  final _apiService = NetworkApiServices();

  Future<List<Post>> getPosts() async {
    try {
      final response = await _apiService.getGetApiResponse(
        url: '$_baseUrl/posts',
      );
      return (response as List).map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<Post> getPost(int id) async {
    try {
      final response = await _apiService.getGetApiResponse(
        url: '$_baseUrl/posts/$id',
      );
      return Post.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load post: $e');
    }
  }
}
