
import '../../settings/model/address_model.dart';
import 'order_item_model.dart';

class OrderModel {
  String? orderId;

  DateTime? createdAt;
  DateTime? expectedDelivery;

  String? orderStatus;
  String? paymentMethod;

  double? totalAmount;
  int? totalItems;

  AddressModel? address;

  List<OrderItemModel>? items;

  OrderModel({
    this.orderId,
    this.createdAt,
    this.expectedDelivery,
    this.orderStatus,
    this.paymentMethod,
    this.totalAmount,
    this.totalItems,
    this.address,
    this.items,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json["orderId"];

    createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : null;

    expectedDelivery = json["expectedDelivery"] != null
        ? DateTime.parse(json["expectedDelivery"])
        : null;

    orderStatus = json["orderStatus"];
    paymentMethod = json["paymentMethod"];

    totalAmount = (json["totalAmount"] as num?)?.toDouble();

    totalItems = json["totalItems"];

    address = json["address"] != null
        ? AddressModel.fromJson(json["address"])
        : null;

    items = json["items"] != null
        ? (json["items"] as List)
        .map((e) => OrderItemModel.fromJson(e))
        .toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "createdAt": createdAt?.toIso8601String(),
      "expectedDelivery": expectedDelivery?.toIso8601String(),
      "orderStatus": orderStatus,
      "paymentMethod": paymentMethod,
      "totalAmount": totalAmount,
      "totalItems": totalItems,
      "address": address?.toJson(),
      "items": items?.map((e) => e.toJson()).toList(),
    };
  }
}