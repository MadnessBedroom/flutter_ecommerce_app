import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/controllers/controller.dart';
import 'package:flutter_ecommerce_app/pages/components/product_grid_view.dart';
import 'package:get/get.dart';

class FavoredPage extends GetView<AppController> {
  const FavoredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: ProductGridView(),
      ),
    );
  }
}
