import 'package:e_store/features/orders/view_model/checkout_View_model.dart';
import 'package:e_store/features/settings/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../settings/model/address_model.dart';
import '../../../settings/view/add_address_screen.dart';
import '../../../settings/view/widgets/address_card.dart';
import '../payment_screen.dart';


class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final addressProvider = context.read<AddressViewModel>();

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * .75,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Select Delivery Address",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<List<AddressModel>>(
                stream: addressProvider.getAddresses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }

                  final addresses = snapshot.data ?? [];

                  if (addresses.isEmpty) {
                    return const Center(child: Text("No Address Found"));
                  }

                  return Consumer<CheckoutViewModel>(
                    builder: (context, checkoutProvider, child) {
                      return ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          final address = addresses[index];

                          return AddressCard(
                            address: address,
                            onTap: () {
                              checkoutProvider.selectAddress(address);
                            },
                            trailing: Radio<String>(
                              value: address.id!,
                              groupValue: checkoutProvider.selectedAddress?.id,
                              onChanged: (_) {
                                checkoutProvider.selectAddress(address);
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddAddressScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Address"),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final checkoutProvider = context.read<CheckoutViewModel>();

                  if (checkoutProvider.selectedAddress == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select an address")),
                    );
                    return;
                  }

                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PaymentScreen()),
                  );
                },
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}