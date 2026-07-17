import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../cart/view/widgets/dialog_helper.dart';
import '../model/address_model.dart';
import '../view_model/address_view_model.dart';
import 'add_address_screen.dart';
import 'widgets/address_card.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddressViewModel>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Addresses",
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddAddressScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder<List<AddressModel>>(
        stream: provider.getAddresses(),
        builder: (context, snapshot) {

          /// Loading
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// Error
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong",
              ),
            );
          }

          final addresses =
              snapshot.data ?? [];

          /// Empty
          if (addresses.isEmpty) {
            return const Center(
              child: Text(
                "No Addresses Found",
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address =
              addresses[index];

              return AddressCard(
                address: address,

                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AddAddressScreen(
                            address: address,
                          ),
                    ),
                  );
                },

                onDelete: () {
                  DialogHelper.show(
                    context: context,
                    title: "Delete Address",
                    message:
                    "Are you sure you want to delete this address?",
                    confirmText: "Delete",
                    onConfirm: () async {
                      Navigator.pop(context);

                      await provider
                          .deleteAddress(
                        address.id!,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}