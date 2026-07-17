import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_store/features/cart/view_model/cart_view_model.dart';
import 'package:e_store/features/shop/view_model/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductViewModel>(context);

    final product = productProvider.selectedProducts;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text("Product not found"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),

      /// ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Product Image
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: product.images != null &&
                      product.images!.isNotEmpty
                      ? product.images!.first
                      : "",
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const SizedBox(
                      height: 320,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const SizedBox(
                      height: 320,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 60,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// Product Title
            Text(
              product.title ?? "",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            /// Category
            Chip(
              label: Text(
                product.category?.name ?? "",
              ),
            ),

            const SizedBox(height: 24),

            /// Description Title
            Text(
              "Description",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            /// Description
            Text(
              product.description ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      /// ---------------- BOTTOM BAR ----------------
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color:Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            children: [

              /// Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const Text(
                      "Price",
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "₹ ${product.price}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              //Add To Cart Button
              Expanded(
                flex: 2,
                child: Consumer<CartViewModel>(
                  builder: (context, cartProvider, child) {
                    return SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: cartProvider.isButtonLoading
                            ? null
                            : () async {
                          await cartProvider.addaToaCart(product);
                        },
                        child: cartProvider.isButtonLoading
                            ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          "Add to Cart",
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}