


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store/features/cart/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
   final FirebaseFirestore firestore = FirebaseFirestore.instance;
   final FirebaseAuth auth = FirebaseAuth.instance;
   String get userId => auth.currentUser!.uid;
   //To Do
    //Collection reference path
CollectionReference<Map<String, dynamic>> get cartRef {
  return firestore.collection("users").doc(userId).collection("cart");
}
//load cart
  Future <List<CartModel>>load() async{
  final snapshot = await cartRef.orderBy('addedAt',descending: true).get();
  return snapshot.docs.
    map((doc)=> CartModel.fromJson(doc.data())).toList();


  }
 // add to cart
Future<void>addToCart(CartModel cart)async{
  final doc = await cartRef.doc(cart.productId).get();
  if (doc.exists){
    final quantity = doc.data()?["quantity"] ?? 1;
    await cartRef.doc(cart.productId).update({
      "quantity" : quantity +1
    });

  }else{
    await cartRef.doc(cart.productId).set(cart.toJson());
  }
}

//increase quantity
Future<void>increaseQuantity(String productId) async{
  final doc = await cartRef.doc(productId).get();
  if(!doc.exists) return;
  final quantity = doc.data()?["quantity"] ??1;
  await cartRef.doc(productId).update({
    "quantity":quantity +1

  });
}
//decrease quantity
Future<void>decreaseQuantity(String productId) async{
  final doc = await cartRef.doc(productId).get();
  if (!doc.exists) return;
  final quantity = doc.data()?["quantity"] ??1;

if (quantity > 1) {
await cartRef.doc(productId).update({
"quantity": quantity - 1,
});
} else {
  // product should be remove
  await cartRef.doc(productId).delete();
}
}
Future<void> removeItem(String productId) async{
  await cartRef.doc(productId).delete();
}
Future<void> clearCart() async{
  final snapshot = await cartRef.get();
  final batch = firestore.batch();

  for(final doc in snapshot.docs){
    batch.delete(doc.reference);
  }
  await batch.commit();

}
}