import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynul_test/src/models/PostModel.dart';
import 'package:mynul_test/src/repository/api/posts_api_service.dart';
import 'package:mynul_test/src/helpers/DatabaseService.dart';

class PostsController extends GetxController {
  final PostsApiService _apiService = PostsApiService();
  final DatabaseService _dbService = DatabaseService.instance;

  final RxList<Post> posts = <Post>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    hasError.value = false;
    error.value = '';

    try {
      // Try to fetch from API
      final fetchedPosts = await _apiService.getPosts();
      posts.value = fetchedPosts;

      // Cache the fetched posts
      await _dbService.savePosts(fetchedPosts);
    } catch (e) {
      hasError.value = true;
      error.value = 'Failed to fetch from API, loading cached data...';

      try {
        // Try to load from cache
        final cachedPosts = await _dbService.getPosts();
        if (cachedPosts.isNotEmpty) {
          posts.value = cachedPosts;
          error.value = 'Showing cached data (offline mode)';
        } else {
          error.value = 'No cached data available';
        }
      } catch (e) {
        error.value = 'Failed to load cached data';
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPosts() async {
    await fetchPosts();
  }
}
