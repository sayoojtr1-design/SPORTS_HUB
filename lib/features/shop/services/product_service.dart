import 'dart:convert';

import 'package:e_store/features/shop/model/category_model.dart';
import 'package:e_store/features/shop/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl="http://api.escuelajs.co/api/v1";

  //get product
  Future<List<ProductModel>>fetchProducts()async{
    final response =await http.get(
        Uri.parse("$baseUrl/products")
    );
    if(response.statusCode==200){
      List data = jsonDecode(response.body);

      return data.map((e)=>ProductModel.fromJson(e)).toList();
    }
    else{
      throw Exception("Failed To Load Products");
    }

  }


  //get categories
  Future<List<CategoryModel>>fetchCategories()async{
    final response= await http.get(
        Uri.parse("$baseUrl/categories")
    );
    if (response.statusCode==200){
      List data= jsonDecode(response.body);

      return data.map((e)=>CategoryModel.fromJson(e)).toList();
    }
    else{
      throw Exception("failed to load categories");
    }
  }

//get product by category
  Future<List<ProductModel>>fetchProductsByCategory(int catId)async{
    final response = await http.get(
        Uri.parse("$baseUrl/categories/$catId/products")
    );
    if (response.statusCode== 200){
      List data= jsonDecode(response.body);

      return data.map((e)=> ProductModel.fromJson(e)).toList();

    }
    else{
      throw Exception("failed To LOad Products In This Category");
    }


  }
  Future<ProductModel>fetchSingleProduct(int productId)async{
    final response = await http.get(
        Uri.parse("$baseUrl/products/$productId")
    );
    if (response.statusCode ==200){
      return ProductModel.fromJson(jsonDecode(response.body));

    }
    else{
      throw Exception("failed to load products");
    }
  }

}