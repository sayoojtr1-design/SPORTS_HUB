import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../root_screen.dart';
import 'order_list_screen.dart';



class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),

                /// Success Animation
                Lottie.asset(
                  "assets/lottie/Add to basket.json",
                  height: 250,
                  repeat: false,
                ),

                const SizedBox(height: 20),

                Text(
                  "Order Placed Successfully!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "Thank you for shopping with us.\nYour order has been placed successfully.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderListScreen(),
                        ),
                            (route) => false,
                      );
                    },
                    child: const Text(
                      "View Orders",
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RootScreen(),
                        ),
                            (route) => false,
                      );
                    },
                    child: const Text(
                      "Continue Shopping",
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}