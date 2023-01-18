import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common/colours.dart';

class RecommendedProduct {
  Color? cardBackgroundColor;
  Color? buttonTextColor;
  Color? buttonBackgroundColor;
  String? imagePath;

  RecommendedProduct(
      {this.cardBackgroundColor,
      this.buttonTextColor = AppColours.darkOrange,
      this.buttonBackgroundColor = Colors.white,
      this.imagePath});
}
