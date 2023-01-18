import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common/colours.dart';
import 'package:flutter_ecommerce_app/common/data.dart';
import 'package:flutter_ecommerce_app/common/enums.dart';
import 'package:flutter_ecommerce_app/components/list_item_selector.dart';
import 'package:flutter_ecommerce_app/pages/components/product_grid_view.dart';
import 'package:flutter_ecommerce_app/controllers/controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<AppController> {
  const HomePage({super.key});

  Widget _buildRecommendProductListView(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: AppData.recommendedProducts.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: AppData.recommendedProducts[index].cardBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '30% OFF DURING \nCOVID 19',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppData.recommendedProducts[index]
                                .buttonBackgroundColor,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            'Get Now',
                            style: TextStyle(
                              color: AppData
                                  .recommendedProducts[index].buttonTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/shopping.png',
                    height: 125,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopCategories(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top categories',
            style: Theme.of(context).textTheme.headline4,
          ),
          TextButton(
            style: const ButtonStyle(
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () => {},
            child: Text(
              'SEE ALL',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.deepOrange.withOpacity(0.7),
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopCategoriesListView() {
    return ListItemSelector(
      categories: controller.state.categories,
      onItemPressed: (index) => controller.filterProductsByCategory(index),
    );
  }

  Widget _appBarActionButton(AppbarActionType actionType) {
    IconData icon = Icons.ac_unit_outlined;
    if (actionType == AppbarActionType.trailing) {
      icon = Icons.search;
    }

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColours.lightGrey,
      ),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => {},
        constraints: const BoxConstraints(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }

  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _appBarActionButton(AppbarActionType.leading),
              _appBarActionButton(AppbarActionType.trailing),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello Person',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  'Lets gets somethings?',
                  style: Theme.of(context).textTheme.headline5,
                ),
                _buildRecommendProductListView(context),
                _buildTopCategories(context),
                _buildTopCategoriesListView(),
                const SizedBox(height: 400, child: ProductGridView())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
