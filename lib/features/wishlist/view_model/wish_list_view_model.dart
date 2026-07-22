import 'package:e_store/features/shop/model/product_model.dart';
import 'package:e_store/features/wishlist/services/wish_list_service.dart';
import 'package:flutter/foundation.dart';

class WishListViewModel extends ChangeNotifier{
  final WishListService service = WishListService();
  List<ProductModel> wishList = [];

  bool isLoading = false;
  bool isInitialized = false;

  //boll wishlist
  void loadWishList(){
    if (isInitialized) return;
    isInitialized = true;
    isLoading = true;

    notifyListeners();
    service.getWishList().listen((products){
      wishList = products;
      isLoading = false;
      notifyListeners();
    });
  }
  //toggle
Future<void> toggleWishList(ProductModel product) async{
    await service.toggleWishList(product);
}
//remove
Future<void> removeFromLWishList(int productId)async{
    await service.removeFromWishList(productId);

    }
    //check
Future<bool> isWishListed(int productId){
    return service.isWishListed(productId);

}//clear
Future<void>clearWishList()async{
    await service.clearWishList();
}

}