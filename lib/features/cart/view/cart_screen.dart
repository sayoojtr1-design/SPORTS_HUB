
import 'package:e_store/features/cart/view/widgets/dialog_helper.dart';
import 'package:e_store/features/cart/view_model/cart_view_model.dart';
import 'package:e_store/features/orders/view/widgets/address_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/cart_item_card.dart';
import 'widgets/cart_loading.dart';
import 'widgets/cart_summary.dart';
import 'widgets/empty_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartViewModel>().loadCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: false,
      ),

      body: Builder(
        builder: (context) {

          if (provider.isLoading) {
            return const CartLoading();
          }

          if (provider.errors != null) {
            return Center(
              child: Text(provider.errors!),
            );
          }

          if (provider.cartItem.isEmpty) {
            return EmptyCart(
              onContinueShopping: () {
                Navigator.pop(context);
              },
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              120,
            ),
            itemCount: provider.cartItem.length,
            itemBuilder: (context, index) {
              final item = provider.cartItem[index];

              return CartItemCard(
                cartItem: item,

                onIncrease: () {
                  provider.increaseQuantity(
                    item.productId!,
                  );
                },

                onDecrease: () {
                  provider.decreaseQuantity(
                    item.productId!,
                  );
                },

                onRemove: () {
                  DialogHelper.show(
                    context: context,
                    title: "Remove Item",
                    message:
                    "Do you want to remove this item from your cart?",
                    onConfirm: () {
                      provider.removeItem(
                        item.productId!,
                      );

                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          );
        },
      ),

      bottomNavigationBar:
      provider.cartItem.isEmpty || provider.isLoading
          ? null
          : CartSummary(
        totalItems:
        provider.getTotalItems(),
        totalPrice:
        provider.getTotalPrice(),
        onCheckout: (){
          showModalBottomSheet(context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)

              ),
              builder: (_)=>AddressBottomSheet());
        },
      ),
    );
  }
}