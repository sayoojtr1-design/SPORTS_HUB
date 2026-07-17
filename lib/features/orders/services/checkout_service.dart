import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../cart/model/cart_model.dart';
import '../../settings/model/address_model.dart';
import '../model/order_item_model.dart';
import '../model/order_model.dart';
class CheckoutService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String get userId => auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get cartRef {
    return firestore
        .collection("users")
        .doc(userId)
        .collection("cart");
  }

  CollectionReference<Map<String, dynamic>> get orderRef {
    return firestore
        .collection("users")
        .doc(userId)
        .collection("orders");
  }

  Future<void> placeOrder({
    required AddressModel address,
    required String paymentMethod,
  }) async {
    final cartSnapshot = await cartRef.get();

    if (cartSnapshot.docs.isEmpty) {
      throw Exception("Cart is empty");
    }

    List<OrderItemModel> orderItems = [];

    double totalAmount = 0;

    int totalItems = 0;

    for (final doc in cartSnapshot.docs) {
      final cart = CartModel.fromJson(doc.data());

      orderItems.add(
        OrderItemModel(
          productId: cart.productId,
          title: cart.title,
          image: cart.image,
          category: cart.category,
          price: cart.price,
          quantity: cart.quantity,
        ),
      );

      totalAmount +=
          (cart.price ?? 0) * (cart.quantity ?? 0);

      totalItems += cart.quantity ?? 0;
    }

    final orderDocument = orderRef.doc();

    final order = OrderModel(
      orderId: orderDocument.id,
      createdAt: DateTime.now(),
      expectedDelivery:
      DateTime.now().add(
        const Duration(days: 5),
      ),
      orderStatus: "Pending",
      paymentMethod: paymentMethod,
      totalAmount: totalAmount,
      totalItems: totalItems,
      address: address,
      items: orderItems,
    );

    final batch = firestore.batch();

    batch.set(
      orderDocument,
      order.toJson(),
    );

    for (final doc in cartSnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}