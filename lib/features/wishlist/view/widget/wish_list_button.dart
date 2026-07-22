import 'package:e_store/core/common/widgets/toast_helper.dart';
import 'package:e_store/features/shop/model/product_model.dart';
import 'package:e_store/features/wishlist/view_model/wish_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListButton extends StatelessWidget {
  final ProductModel product;
  const WishListButton({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<WishListViewModel>(builder: (context, wlProvider, child) {
      final isWishlisted = wlProvider.wishList.any(
            (item) => item.id == product.id,
      );
      return IconButton(onPressed: () async {
        await wlProvider.toggleWishList(product);

        if (context.mounted){
          ToastHelper.show(isWishlisted ? "Removed from Wishlist "
                                             :"Added to Wishlist"
          );
        }
      }, icon: Icon(isWishlisted ? Icons.favorite : Icons.favorite_border,
        color: isWishlisted ? Colors.red : Colors.black,
      ));
    });
  }

}
