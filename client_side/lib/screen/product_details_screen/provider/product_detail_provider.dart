import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sad/models/product.dart';
import 'package:sad/utility/snack_bar_helper.dart';
import 'package:sad/utility/utility_extention.dart';
import '../../../core/data/data_provider.dart';
import '../../product_cart_screen/cart_screen.dart';


class ProductDetailProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  String? selectedVariant;
  var flutterCart = FlutterCart();

  ProductDetailProvider(this._dataProvider);

  addToCart(Product product){
    if(product.proVariantId!.isNotEmpty && selectedVariant == null){
      SnackBarHelper.showErrorSnackBar("Please select a variant");
      return;
    }
    double? price = product.offerPrice != product.price? product.offerPrice:product.price;
    flutterCart.addToCart(cartModel: CartModel(
        productId: '${product.sId}',
        productName: '${product.name}',
        productImages: ['${product.images?.safeElementAt(0)?.url}'],
        variants: [ProductVariant(price: price ?? 0, color: selectedVariant)],
        productDetails: '${product.description}'
    ));
    selectedVariant = null;
    SnackBarHelper.showSuccessSnackBar("Item added");
    notifyListeners();
  }


  void updateUI() {
    notifyListeners();
  }
}
