import 'package:cloud_firestore/cloud_firestore.dart';


import '../../shop/model/product_model.dart';



class CartModel {
  String? productId;
  String? title;
  double? price;
  String? image;
  String? category;
  int? quantity;
  Timestamp? addedAt;

  CartModel({
    this.productId,
    this.title,
    this.price,
    this.image,
    this.category,
    this.quantity,
    this.addedAt,
  });

  factory CartModel.fromProduct(ProductModel product) {
    return CartModel(
      productId: product.id.toString(),
      title: product.title,
      price: (product.price ?? 0).toDouble(),
      image: product.images != null && product.images!.isNotEmpty
          ? product.images!.first
          : "",
      category: product.category?.name,
      quantity: 1,
      addedAt: Timestamp.now(),
    );
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json["productId"];
    title = json["title"];
    price = (json["price"] as num).toDouble();
    image = json["image"];
    category = json["category"];
    quantity = json["quantity"];
    addedAt = json["addedAt"];
  }

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "title": title,
      "price": price,
      "image": image,
      "category": category,
      "quantity": quantity,
      "addedAt": addedAt,
    };
  }
}