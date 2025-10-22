import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynul_test/src/controllers/PostsController.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/constants/Colors.dart';
import 'package:mynul_test/src/utils/utils.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key}) : super(key: key);

  final PostsController controller = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('Posts', fontSize: 20, fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => controller.refreshPosts(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.brandColor),
          );
        }

        if (controller.hasError.value && controller.posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  controller.error.value,
                  fontSize: 16,
                  fontColor: AppColors.placeHolder,
                ),
                Utils.vertS(20),
                ElevatedButton(
                  onPressed: () => controller.refreshPosts(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            if (controller.error.value.isNotEmpty)
              Container(
                width: double.infinity,
                color: Colors.amber.withOpacity(0.3),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: AppText(
                  controller.error.value,
                  fontSize: 14,
                  fontColor: Colors.amber[900],
                ),
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.refreshPosts(),
                child: ListView.builder(
                  itemCount: controller.posts.length,
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final post = controller.posts[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              post.title,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            Utils.vertS(8),
                            AppText(
                              post.body,
                              fontSize: 14,
                              fontColor: AppColors.placeHolder,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
