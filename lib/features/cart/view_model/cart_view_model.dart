import 'package:e_store/core/common/widgets/toast_helper.dart';
import 'package:e_store/features/cart/model/cart_model.dart';
import 'package:e_store/features/cart/services/cart_service.dart';
import 'package:flutter/cupertino.dart';

import '../../shop/model/product_model.dart';

class CartViewModel extends ChangeNotifier {
  //instance of cart service class
  final CartService service = CartService();

  //list  for products added to cart
  List<CartModel> cartItem = [];

  //loading states
  bool isLoading = false;
  bool isButtonLoading = false;

  //error
  String? errors;

  //methode to load Cart
  Future<void> loadCart() async {
    isLoading = true;
    errors = null;
    notifyListeners();
    cartItem = await service.load();
    try {
      cartItem = await service.load();
    } catch (e) {
      errors = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  // methode to add to card
  Future<void> addaToaCart(ProductModel product) async {
    if (isButtonLoading) return;
    isButtonLoading = false;
    notifyListeners();
    try {
      final cartItem = CartModel.fromProduct(product);
      await service.addToCart(cartItem);
      await loadCart();
      ToastHelper.show("add to cart");
    } catch (e) {
      errors = e.toString();
      ToastHelper.show(errors!);
    }
    isButtonLoading = false;
    notifyListeners();
  }

  //increase quantity

  Future<void> increaseQuantity(String productId) async {
    try {
      await service.increaseQuantity(productId);
      await loadCart();
    } catch (e) {
      errors = e.toString();
      notifyListeners();
    }
  }

  //decrease quantity
  Future<void> decreaseQuantity(String productId) async {
    try {
      await service.decreaseQuantity(productId);
      await loadCart();
    } catch (e) {
      errors = e.toString();
      notifyListeners();
    }
  }

  //   remove item
  Future<void> removeItem(String productId) async {
    try {
      await service.removeItem(productId);
      await loadCart();
      ToastHelper.show("Item Removed");
    } catch (e) {
      errors = e.toString();
      ToastHelper.show(errors!);
    }
    notifyListeners();
  }

  // clear cart
  Future<void> clearCart() async {
    try {
      await service.clearCart();
      cartItem.clear();
      ToastHelper.show("Cart Cleared");
    } catch (e) {
      errors = e.toString();
      ToastHelper.show(errors!);
    }
    notifyListeners();
  }

  //get total item
  int getTotalItems() {
    int total = 0;
    for (final item in cartItem) {
      total += item.quantity ?? 0;
    }
    return total;
  }

  double getTotalPrice() {
    double total = 0;
    for (final item in cartItem) {
      total += (item.price ?? 0) * (item.quantity ?? 0);
    }
    return total;
  }
}
