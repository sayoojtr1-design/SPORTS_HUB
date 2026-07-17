import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store/features/shop/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import '../../model/product_model.dart';
import 'product_grid_shimmer.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  final bool isLoading;
  final String? error;
  final Function(ProductModel) onProductTap;

  const ProductGrid({
    super.key,
    required this.products,
    required this.isLoading,
    required this.error,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ProductGridShimmer();
    }

    if (error != null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Text(
            error!,
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
          ),
        ),
      );
    }

    if (products.isEmpty) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 60,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 12),
              Text(
                "No Products Found",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: products.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index], onTap: () =>
              onProductTap(products[index]),
          );
        }
    );
  }
}