import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/order_model.dart';



class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final item = order.items!.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// PRODUCT
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: item.image ?? "",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return const SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return const SizedBox(
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          item.title ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Category",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall,
                        ),

                        Text(item.category ?? ""),

                        const SizedBox(height: 10),

                        Text(
                          "Quantity",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall,
                        ),

                        Text(
                          "${item.quantity}",
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Price",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall,
                        ),

                        Text(
                          "₹ ${item.price}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// ORDER STATUS
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    "Order Status",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.orderStatus ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// DELIVERY DETAILS
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    "Delivery Details",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Expected Delivery",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),

                  Text(
                    order.expectedDelivery != null
                        ? DateFormat(
                      "dd MMM yyyy",
                    ).format(
                      order.expectedDelivery!,
                    )
                        : "-",
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "Payment Method",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),

                  Text(
                    order.paymentMethod ?? "",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// DELIVERY ADDRESS
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    "Delivery Address",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    order.address?.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    order.address?.phone ?? "",
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "${order.address?.house}, "
                        "${order.address?.area}, "
                        "${order.address?.city}, "
                        "${order.address?.state} - "
                        "${order.address?.pincode}",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// ORDER SUMMARY
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  Row(
                    children: [

                      const Text("Total Items"),

                      const Spacer(),

                      Text(
                        "${order.totalItems}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 24),

                  Row(
                    children: [

                      const Text("Total Amount"),

                      const Spacer(),

                      Text(
                        "₹ ${order.totalAmount}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}