import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/order_model.dart';




class OrderService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String get userId => auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get orderRef {
    return firestore
        .collection("users")
        .doc(userId)
        .collection("orders");
  }

  /// Get All Orders
  Stream<List<OrderModel>> getOrders() {
    return orderRef
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => OrderModel.fromJson(
          doc.data(),
        ),
      )
          .toList(),
    );
  }

  /// Get Single Order
  Future<OrderModel?> getOrder(String orderId) async {
    final document =
    await orderRef.doc(orderId).get();

    if (!document.exists) {
      return null;
    }

    return OrderModel.fromJson(
      document.data()!,
    );
  }
}