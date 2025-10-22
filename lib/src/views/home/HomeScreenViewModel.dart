import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mynul_test/src/helpers/DatabaseHelper.dart';
import 'package:mynul_test/src/models/ProductModel.dart';
import 'package:mynul_test/src/repository/api/network/NetworkApiServices.dart';
import 'package:mynul_test/src/utils/utils.dart';

class HomeScreenViewmodel extends ChangeNotifier {
  late final BuildContext context;
  final _apiServices = NetworkApiServices();
  List<Product> productList = [];

  init(BuildContext context) {
    this.context = context;
    _getProducts();
    notifyListeners();
  }

  Future<void> _getProducts() async {
    final rawList = await DatabaseHelper.instance.getAllProducts();
    productList = await compute<List<Map<String, dynamic>>, List<Product>>(
      parseProductsInBackground,
      rawList,
    );

    if (productList.isEmpty) {
      await _getProductsFromApi();
    }

    notifyListeners();
  }

  _getProductsFromApi() async {
    Utils.snackBarDefaultMessage("Getting product list from Api");
    final products = await _apiServices.getGetApiResponse(
      url: 'https://dummyjson.com/products',
    );

    if (products != null) {
      productList = ProductDataModel.fromMap(products).products!;

      for (var p in productList) {
        await DatabaseHelper.instance.insertProduct(p);
      }
    }
    notifyListeners();
  }
}

List<Product> parseProductsInBackground(List<Map<String, dynamic>> data) {
  return data.map((e) => Product.fromDatabase(e)).toList();
}
