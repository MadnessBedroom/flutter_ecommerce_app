import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/models/product_category.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListItemSelector extends StatefulWidget {
  const ListItemSelector(
      {super.key, required this.categories, required this.onItemPressed});

  final List<ProductCategory> categories;
  final Function(int) onItemPressed;

  @override
  State<ListItemSelector> createState() => _ListItemSelectorState();
}

class _ListItemSelectorState extends State<ListItemSelector> {
  Widget _buildItem(ProductCategory category, int index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 500),
      width: 50,
      height: 100,
      decoration: BoxDecoration(
        color: category.isSelected == false
            ? const Color(0xffe5e6e8)
            : const Color(0xfff16b26),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        splashRadius: 0.1,
        icon: FaIcon(
          category.icon,
          color: category.isSelected == false
              ? const Color(0xffa6a3a0)
              : Colors.white,
        ),
        onPressed: () {
          widget.onItemPressed(index);
          for (var item in widget.categories) {
            item.isSelected = false;
          }

          category.isSelected = true;
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (_, index) {
          return _buildItem(widget.categories[index], index);
        },
      ),
    );
  }
}
