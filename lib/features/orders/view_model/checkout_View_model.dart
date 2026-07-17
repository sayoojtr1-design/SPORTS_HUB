import 'package:flutter/material.dart';

import '../../settings/model/address_model.dart';
import '../services/checkout_service.dart';
class CheckoutViewModel extends ChangeNotifier {
  final CheckoutService checkoutService = CheckoutService();

  bool isLoading = false;

  AddressModel? selectedAddress;

  String? selectedPaymentMethod;

  /// -----------------------------
  /// SELECT ADDRESS
  /// -----------------------------

  void selectAddress(AddressModel address) {
    selectedAddress = address;
    notifyListeners();
  }

  /// -----------------------------
  /// SELECT PAYMENT
  /// -----------------------------

  void selectPaymentMethod(String paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }

  /// -----------------------------
  /// PLACE ORDER
  /// -----------------------------

  Future<void> placeOrder() async {
    if (selectedAddress == null) {
      throw Exception("Please select an address");
    }

    if (selectedPaymentMethod == null) {
      throw Exception("Please select a payment method");
    }

    isLoading = true;
    notifyListeners();

    try {
      await checkoutService.placeOrder(
        address: selectedAddress!,
        paymentMethod: selectedPaymentMethod!,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// -----------------------------
  /// RESET CHECKOUT
  /// -----------------------------

  void reset() {
    selectedAddress = null;
    selectedPaymentMethod = null;
    notifyListeners();
  }
}