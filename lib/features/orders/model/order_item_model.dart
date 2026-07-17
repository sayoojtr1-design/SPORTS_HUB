class OrderItemModel {
  String? productId;
  String? title;
  String? image;
  String? category;
  double? price;
  int? quantity;

  OrderItemModel({
    this.productId,
    this.title,
    this.image,
    this.category,
    this.price,
    this.quantity,
  });

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    productId = json["productId"];
    title = json["title"];
    image = json["image"];
    category = json["category"];
    price = (json["price"] as num?)?.toDouble();
    quantity = json["quantity"];
  }

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "title": title,
      "image": image,
      "category": category,
      "price": price,
      "quantity": quantity,
    };
  }
}