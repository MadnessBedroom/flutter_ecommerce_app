import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common/extensions.dart';
import 'package:flutter_ecommerce_app/components/animated_switcher_wrapper.dart';
import 'package:flutter_ecommerce_app/components/empty_cart.dart';
import 'package:flutter_ecommerce_app/controllers/controller.dart';
import 'package:flutter_ecommerce_app/models/product.dart';
import 'package:get/get.dart';

class CartPage extends GetView<AppController> {
  const CartPage({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'My Cart',
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _buildCartListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: controller.state.cartProducts.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        Product product = controller.state.cartProducts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(15),
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200]?.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorExtension.randomColor,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      product.images[0],
                      width: 70,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.name.nextLine,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      controller.getCurrentSize(product),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      controller.isPriceOff(product)
                          ? "\$${product.off}"
                          : "\$${product.price}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 23),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 10,
                      onPressed: () => controller.decreaseProduct(index),
                      icon: const Icon(
                        Icons.remove,
                        color: Color(0xffec6813),
                      ),
                    ),
                    GetBuilder<AppController>(
                      builder: (controller) {
                        return AnimatedSwitcherWrapper(
                          child: Text(
                            '${controller.state.cartProducts[index].quantity}',
                            key: ValueKey<int>(
                                controller.state.cartProducts[index].quantity),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      splashRadius: 10,
                      onPressed: () => controller.increaseProduct(index),
                      icon: const Icon(
                        Icons.add,
                        color: Color(0xffec6813),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBarTitle() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            Obx(
              () => AnimatedSwitcherWrapper(
                child: Text(
                  '\$${controller.state.totalPrice.value}',
                  key: ValueKey<int>(controller.state.totalPrice.value),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color(0xffec6813),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBuyButton() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: ElevatedButton(
            onPressed: controller.isEmptyCart ? null : () {},
            child: const Text('Buy Now'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: !controller.isEmptyCart
                ? _buildCartListView()
                : const EmptyCart(),
          ),
          _buildBottomBarTitle(),
          _buildBuyButton(),
        ],
      ),
    );
  }
}
