import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/common/enums.dart';
import 'package:flutter_ecommerce_app/common/extensions.dart';
import 'package:flutter_ecommerce_app/controllers/state.dart';
import 'package:flutter_ecommerce_app/models/numerical.dart';
import 'package:flutter_ecommerce_app/models/product.dart';
import 'package:flutter_ecommerce_app/models/product_category.dart';
import 'package:flutter_ecommerce_app/models/product_size_type.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final AppState state = AppState();
  PageController pageController = PageController(initialPage: 0);

  void switchBetweenBottomNavigationItems(int index) {
    switch (index) {
      case 0:
        state.filteredProducts.assignAll(state.allProducts);
        break;
      case 1:
        getLikedProducts();
        break;
      case 2:
        state.cartProducts
            .assignAll(state.allProducts.where((item) => item.quantity > 0));
        break;
      default:
    }
    state.currentBottomNavItemIndex.value = index;
  }

  void switchBetweenProductImages(int index) {
    state.productImageDefaultIndex.value = index;
  }

  // when click on category filter the product
  void filterProductsByCategory(int index) {
    for (ProductCategory element in state.categories) {
      element.isSelected = false;
    }
    state.categories[index].isSelected = true;

    if (state.categories[index].type == ProductType.all) {
      state.filteredProducts.assignAll(state.allProducts);
    } else {
      state.filteredProducts.assignAll(state.allProducts.where((item) {
        return item.type == state.categories[index].type;
      }).toList());
    }
  }

  // when click favorite button
  void isLiked(int index) {
    state.filteredProducts[index].isLiked =
        !state.filteredProducts[index].isLiked;
    state.filteredProducts.refresh();
  }

  void calculateTotalPrice() {
    state.totalPrice.value = 0;
    for (var element in state.cartProducts) {
      if (isPriceOff(element)) {
        state.totalPrice.value += element.quantity * element.off!;
      } else {
        state.totalPrice.value += element.quantity * element.price;
      }
    }
  }

  void decreaseProduct(int index) {
    Product product = state.cartProducts[index];
    if (product.quantity > 0) {
      product.quantity--;
    }

    calculateTotalPrice();
    update();
  }

  void increaseProduct(int index) {
    Product product = state.cartProducts[index];
    product.quantity++;
    calculateTotalPrice();
    update();
  }

  // get liked products
  void getLikedProducts() => state.filteredProducts
      .assignAll(state.allProducts.where((item) => item.isLiked));

  // is there a discount on the product
  bool isPriceOff(Product product) => product.off != null ? true : false;

  // shopping cart empty or not
  bool get isEmptyCart =>
      state.cartProducts.isEmpty || isZeroQuantity ? true : false;

  bool isNominal(Product product) =>
      product.sizes?.numerical != null ? true : false;

  bool get isZeroQuantity {
    return state.cartProducts.any(
      (element) {
        return element.price.compareTo(0) == 0 ? true : false;
      },
    );
  }

  String getCurrentSize(Product product) {
    String currentSize = "";
    if (product.sizes?.categorical != null) {
      for (var element in product.sizes!.categorical!) {
        if (element.isSelected) {
          currentSize = "Size:${element.categorical.name}";
        }
      }
    }

    if (product.sizes?.numerical != null) {
      for (var element in product.sizes!.numerical!) {
        if (element.isSelected) {
          currentSize = "Size:${element.numerical}";
        }
      }
    }
    return currentSize;
  }

  void switchBetweenProductSizes(Product product, int index) {
    sizeType(product).forEach((element) {
      element.isSelected = false;
    });

    if (product.sizes?.categorical != null) {
      for (var element in product.sizes!.categorical!) {
        element.isSelected = false;
      }

      product.sizes?.categorical![index].isSelected = true;
    }

    if (product.sizes?.numerical != null) {
      for (var element in product.sizes!.numerical!) {
        element.isSelected = false;
      }

      product.sizes?.numerical![index].isSelected = true;
    }

    update();
  }

  List<Numerical> sizeType(Product product) {
    ProductSizeType? productSize = product.sizes;
    List<Numerical> numericalList = [];

    if (productSize?.numerical != null) {
      for (var element in productSize!.numerical!) {
        numericalList.add(Numerical(element.numerical, element.isSelected));
      }
    }

    if (productSize?.categorical != null) {
      for (var element in productSize!.categorical!) {
        numericalList
            .add(Numerical(element.categorical.name, element.isSelected));
      }
    }

    return numericalList;
  }

  void addToCart(Product product) {
    product.quantity++;
    state.cartProducts.add(product);
    state.cartProducts.assignAll(state.cartProducts.distinctBy((item) => item));
    EasyLoading.showSuccess(
      'added to cart!',
      duration: const Duration(
        milliseconds: 800,
      ),
    );
    calculateTotalPrice();
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
