import 'package:e_store/features/shop/model/product_model.dart';
import 'package:e_store/features/shop/view/product_detail_screen.dart';
import 'package:e_store/features/shop/view/widgets/custom_searchbar.dart';
import 'package:e_store/features/shop/view/widgets/product_grid.dart';
import 'package:e_store/features/shop/view/widgets/selection_title.dart';
import 'package:e_store/features/shop/view_model/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/carousel_widget.dart';
import 'widgets/category_list.dart';
import 'widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().loadHomeData();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _openProduct(
      ProductViewModel provider,
      ProductModel product,
      ) async {
    await provider.fetchSingleProduct(product.id!);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductDetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Store"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: provider.isHomeLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
        slivers: [
          /// Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: CustomSearchBar(
                controller: searchController,
                onChanged: (value) {
                  provider.searchProducts(value);
                },
              ),
            ),
          ),

          /// Carousel
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CarouselWidget(
                images: provider.allProducts
                    .take(5)
                    .map(
                      (product) => product.images?.isNotEmpty == true
                      ? product.images!.first
                      : "",
                )
                    .toList(),
              ),
            ),
          ),

          /// Categories Title
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SectionTitle(title: "Categories"),
            ),
          ),

          /// Categories
          SliverToBoxAdapter(
            child: CategoryList(
              categories: provider.categories,
              selectedCategoryId: provider.selectedCategoryId,
              onCategorySelected: provider.fetchProductsByCategory,
            ),
          ),

          /// Products Title
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: SectionTitle(title: "Products"),
            ),
          ),

          /// Product Grid
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: ProductGrid(
                products: provider.displayedProducts,
                isLoading: provider.isProductsLoading,
                error: provider.error,
                onProductTap: (product) {
                  _openProduct(provider, product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}