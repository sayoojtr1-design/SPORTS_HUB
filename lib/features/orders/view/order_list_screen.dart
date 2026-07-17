import 'package:e_store/features/orders/view_model/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/common/widgets/custom_button.dart';
import '../../../root_screen.dart';
import '../model/order_model.dart';
import 'order_detial_screen.dart';
import 'widgets/order_card.dart';
import 'widgets/order_empty.dart';
import 'widgets/order_loading.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OrderViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: StreamBuilder<List<OrderModel>>(
        stream: provider.getOrders(),
        builder: (context, snapshot) {
          /// Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const OrderLoading();
          }

          /// Error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final orders = snapshot.data ?? [];

          /// Empty
          if (orders.isEmpty) {
            return const OrderEmpty();
          }

          /// Orders
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return OrderCard(
                order: order,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailsScreen(order: order),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomButton(
        text: "Go and Shop Again",
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => RootScreen()),
                (route) => false,
          );
        },
      ),
    );
  }
}