import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common/enums.dart';

class ProductCategory {
  ProductType type;
  bool isSelected;
  IconData icon;

  ProductCategory(this.type, this.isSelected, this.icon);
}
