import 'package:e_store/features/shop/model/product_model.dart';
import 'package:e_store/features/shop/view/product_detail_screen.dart';
import 'package:e_store/features/shop/view/widgets/product_grid.dart';
import 'package:e_store/features/shop/view/widgets/product_grid_shimmer.dart';
import 'package:e_store/features/shop/view_model/product_view_model.dart';
import 'package:e_store/features/wishlist/view_model/wish_list_view_model.dart';
import 'package:e_store/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishListViewModel>().loadWishList();
    });
  }

  Future<void> _openProduct(
      ProductViewModel productProvider,
      ProductModel product,
      ) async {
    await productProvider.fetchSingleProduct(product.id!);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProductDetailsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = context.watch<WishListViewModel>();
    final productProvider = context.read<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
      ),
      body: Builder(
        builder: (context) {
          if (wishlistProvider.isLoading) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: ProductGridShimmer(),
            );
          }

          if (wishlistProvider.wishList.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Colors.grey,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Your Wishlist is Empty",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Start adding products you love.\nThey'll appear here.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> RootScreen()), (route)=> false);
                      },
                      child: const Text(
                        "Continue Shopping",
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ProductGrid(
              products: wishlistProvider.wishList,
              isLoading: false,
              error: null,
              onProductTap: (product) {
                _openProduct(productProvider, product);
              },
            ),
          );
        },
      ),
    );
  }
}