import 'package:flutter/material.dart';

import '../../../../root_screen.dart';


class OrderEmpty extends StatelessWidget {
  const OrderEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.shopping_bag_outlined,
              size: 100,
            ),

            const SizedBox(height: 24),

            Text(
              "No Orders Yet",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Looks like you haven't placed any orders yet.\nStart shopping to see your orders here.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
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
          ],
        ),
      ),
    );
  }
}