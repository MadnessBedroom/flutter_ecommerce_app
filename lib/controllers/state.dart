import 'package:flutter_ecommerce_app/common/data.dart';
import 'package:flutter_ecommerce_app/models/product.dart';
import 'package:flutter_ecommerce_app/models/product_category.dart';
import 'package:get/get.dart';

class AppState {
  RxList<Product> allProducts = AppData.products.obs;
  RxList<ProductCategory> categories = AppData.categories.obs;
  RxList<Product> filteredProducts = AppData.products.obs;
  RxList<Product> cartProducts = <Product>[].obs;
  RxInt productImageDefaultIndex = 0.obs;
  RxInt currentBottomNavItemIndex = 0.obs;
  RxInt totalPrice = 0.obs;
}
