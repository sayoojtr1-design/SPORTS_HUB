import 'package:e_store/features/shop/model/category_model.dart';
import 'package:e_store/features/shop/services/product_service.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  // instance of service class

  final ProductService service= ProductService();

  //list of all products
  List<ProductModel> allProducts =[];
//list of currently selected category products
  List<ProductModel> currentProducts=[];
//products to display on screen
  List<ProductModel> displayedProducts=[];
  //categories
  List<CategoryModel> categories=[];
//selected products
  ProductModel? selectedProducts;
//loading states
  bool isHomeLoading= false;
  bool isProductsLoading= false;
//error
  String? error;
//all categories
  int selectedCategoryId=0;

// load homepage
  Future<void>loadHomeData()async{
    isHomeLoading= true;
    notifyListeners();
    try{
      await Future.wait([fetchCategories(),fetchProducts()]);
    }
    catch(e){
      error= e.toString();
    }
    isHomeLoading = false;
    notifyListeners();
  }
// fetch products
  Future<void>fetchProducts()async{
    try{
      allProducts=await service.fetchProducts();

      currentProducts= List.from(allProducts);
      displayedProducts = List.from(allProducts);
      selectedCategoryId=0;
    }catch(e){
      error= e.toString();
    }
    notifyListeners();
  }
// fetch categories
  Future<void> fetchCategories()async{
    try{
      categories= await service.fetchCategories();
    }catch(e){
      error = e.toString();
    }
    notifyListeners();
  }

// fetch products by category
  Future<void>fetchProductsByCategory(int catId)async{
    isProductsLoading=true;
    selectedCategoryId=catId;
    notifyListeners();
    try{
      if(catId==0){
        currentProducts= List.from(allProducts);
      }else{
        currentProducts= await service.fetchProductsByCategory(catId);
      }
      displayedProducts = List.from(currentProducts);
      error=null;
    }catch(e){
      error= e.toString();
    }
    isProductsLoading=false;
    notifyListeners();
  }
// fetch singleProduct
  Future<void>fetchSingleProduct (int productId)async{
    try{
      selectedProducts = await service.fetchSingleProduct(productId);
      error = null;
    }
    catch(e){
      error = e.toString();
    }
    notifyListeners();
  }
  // search product
  void searchProducts(String value){
    if(value.trim().isEmpty){
      displayedProducts= List.from(currentProducts);
    }else{
      displayedProducts= currentProducts.where((product){
        return (product.title?? "").toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
  void clearSearch(){
    displayedProducts=List.from(currentProducts);
    notifyListeners();
  }
}