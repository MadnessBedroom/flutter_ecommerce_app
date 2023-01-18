import 'package:flutter_ecommerce_app/models/categorical.dart';
import 'package:flutter_ecommerce_app/models/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({this.numerical, this.categorical});
}
