import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/constants/Colors.dart';
import 'package:mynul_test/src/models/ProductModel.dart';
import 'package:mynul_test/src/utils/utils.dart';
import 'package:mynul_test/src/views/home/HomeScreenViewModel.dart';
import 'package:mynul_test/src/views/home/components/animated_rating.dart';
import 'package:mynul_test/src/views/posts/PostsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenViewmodel _homeViewmodel;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeViewmodel = HomeScreenViewmodel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeViewmodel.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _homeViewmodel,

      child: Consumer<HomeScreenViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.productList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 120.0,
                      floating: true,
                      pinned: true,
                      elevation: 0,
                      backgroundColor: AppColors.brandColor,
                      flexibleSpace: FlexibleSpaceBar(
                        title: AppText(
                          'Eduline',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.white,
                        ),
                        centerTitle: false,
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.white),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              'Popular Courses',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            Utils.vertS(16),
                            Container(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: viewModel.productList.length,
                                itemBuilder: (context, index) {
                                  final product = viewModel.productList[index];
                                  return _buildFeaturedCourse(product);
                                },
                              ),
                            ),
                            Utils.vertS(24),
                            AppText(
                              'All Courses',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            Utils.vertS(16),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final product = viewModel.productList[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: _buildCourseCard(product),
                          );
                        }, childCount: viewModel.productList.length),
                      ),
                    ),
                  ],
                ),
                PostsScreen(),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedIndex: _selectedIndex,
              destinations: const <NavigationDestination>[
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                  icon: Icon(Icons.article),
                  label: 'Posts',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedCourse(Product product) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: product.thumbnail!,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  product.title!,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                ),
                Utils.vertS(4),
                Row(
                  children: [
                    ProductRating(
                      rating: product.rating,
                      colors: [Colors.amber, Colors.amber.shade200],
                    ),
                    Spacer(),
                    AppText(
                      '\$${product.price}',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.brandColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: product.thumbnail!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    product.title!,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                  ),
                  Utils.vertS(8),
                  Row(
                    children: [
                      ProductRating(
                        rating: product.rating,
                        colors: [Colors.amber, Colors.amber.shade200],
                      ),
                      Spacer(),
                      if (product.discountPercentage! > 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: AppText(
                            '-${product.discountPercentage!.round()}%',
                            fontSize: 12,
                            fontColor: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Utils.horiS(8),
                      AppText(
                        '\$${product.price}',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontColor: AppColors.brandColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
