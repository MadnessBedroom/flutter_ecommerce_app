import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/components/open_container_wrapper.dart';
import 'package:flutter_ecommerce_app/controllers/controller.dart';
import 'package:flutter_ecommerce_app/models/product.dart';
import 'package:get/get.dart';

class ProductGridView extends GetView<AppController> {
  const ProductGridView({super.key});

  Widget _buildGridItemHeader(Product product, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: controller.isPriceOff(product),
            child: Container(
              width: 80,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: const Text(
                '30% OFF',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: controller.state.filteredProducts[index].isLiked
                  ? Colors.redAccent
                  : const Color(0xffa6a3a0),
            ),
            onPressed: () => controller.isLiked(index),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItemBody(Product product) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xffe5e6e8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(
        product.images[0],
        scale: 3,
      ),
    );
  }

  Widget _buildGridItemFooter(Product product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  product.off != null
                      ? '\$${product.off}'
                      : '\$${product.price}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(width: 3),
                Visibility(
                  visible: product.off != null ? true : false,
                  child: Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.state.filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 10 / 16,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (_, index) {
            Product product = controller.state.filteredProducts[index];
            return OpenContainerWrapper(
              product: product,
              child: GridTile(
                header: _buildGridItemHeader(product, index),
                footer: _buildGridItemFooter(product, context),
                child: _buildGridItemBody(product),
              ),
            );
          },
        ),
      ),
    );
  }
}
