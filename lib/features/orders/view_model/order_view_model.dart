import 'package:flutter/material.dart';
import '../model/order_model.dart';
import '../services/order_service.dart';


class OrderViewModel extends ChangeNotifier {
  final OrderService orderService = OrderService();

  bool isLoading = false;

  OrderModel? selectedOrder;

  /// -----------------------------
  /// GET ALL ORDERS
  /// -----------------------------

  Stream<List<OrderModel>> getOrders() {
    return orderService.getOrders();
  }

  /// -----------------------------
  /// GET SINGLE ORDER
  /// -----------------------------

  Future<void> getOrder(String orderId) async {
    isLoading = true;
    notifyListeners();

    try {
      selectedOrder =
          await orderService.getOrder(orderId);
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  /// -----------------------------
  /// CLEAR SELECTED ORDER
  /// -----------------------------

  void clearSelectedOrder() {
    selectedOrder = null;
    notifyListeners();
  }
}