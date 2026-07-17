import 'package:e_store/features/orders/view/success_screen.dart';
import 'package:e_store/features/orders/view/widgets/payment_title.dart';
import 'package:e_store/features/orders/view_model/checkout_View_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/common/widgets/toast_helper.dart';
import '../../../core/constants/payment_constats.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CheckoutViewModel>(context);

    final address = provider.selectedAddress!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// Delivery Address
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
                    "Deliver To",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    address.name ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(address.phone ?? ""),

                  const SizedBox(height: 10),

                  Text(
                    "${address.house}, "
                        "${address.area}, "
                        "${address.city}, "
                        "${address.state} - "
                        "${address.pincode}",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            "Select Payment Method",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          /// Payment Methods
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PaymentMethods.options.length,
            itemBuilder: (context, index) {
              final payment = PaymentMethods.options[index];

              return PaymentTile(
                title: payment.title,
                image: payment.image,
                isSelected:
                provider.selectedPaymentMethod ==
                    payment.title,
                onTap: () {
                  provider.selectPaymentMethod(
                    payment.title,
                  );
                },
              );
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: provider.isLoading
                  ? null
                  : () async {
                try {
                  await provider.placeOrder();

                  if (!context.mounted) return;

                  provider.reset();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const SuccessScreen(),
                    ),
                  );
                } catch (e) {
                  ToastHelper.show(
                    e.toString(),
                  );
                }
              },
              child: provider.isLoading
                  ? const SizedBox(
                height: 22,
                width: 22,
                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
                "Place Order",
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}