import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store/features/shop/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishListService {
   final FirebaseAuth auth = FirebaseAuth.instance;
   final FirebaseFirestore firestore = FirebaseFirestore.instance;


   //get the collection reference path

   CollectionReference<Map<String,dynamic>> get wishListRef{
     final uid = auth.currentUser!.uid;

     return firestore.collection("users")
         .doc(uid)
         .collection("wishList");
   }

   //add to wishlist
Future<void> addWishList(ProductModel product) async{
     await wishListRef.doc(product.id.toString()).set({
       "id":product.id,
       "title":product.title,
       "slug":product.slug,
       "price":product.price,
       "description":product.description,
       'category':{
         "id":product.category?.id,
         "name":product.category?.name,
         "slug":product.category?.slug,
         "image":product.category?.image,
         "creationAt":product.category?.creationAt,
         "updatedAt":product.category?.updatedAt,
       },
       "images":product.images,
       "creationAt":product.creationAt,
       "updatedAt":product.updatedAt,
       "addedAt":FieldValue.serverTimestamp(),

     });
}
//remove from wishlist
Future<void> removeFromWishList(int productId) async{
     await wishListRef.doc(productId.toString()).delete();
}
//toggle value
Future<void> toggleWishList(ProductModel product)async{
     final doc =  await wishListRef.doc(product.id.toString()).get();

     if (doc.exists){
       await removeFromWishList(product.id!);
     }else{
       await addWishList(product);
     }

}
//check if wishlisted
Future<bool> isWishListed(int productId) async{
     final doc = await wishListRef.doc(productId.toString()).get();
     return doc.exists;
}
//get all wishlisted products

Stream<List<ProductModel>>getWishList(){
     return wishListRef.orderBy("addedAt",descending:true)
         .snapshots()
         .map((snapshot){
           return snapshot.docs.map((doc){
             final data = doc.data();

             return ProductModel(
               id: data["id"],
               title: data["title"],
               slug: data["slug"],
               price: data["price"],
               description: data["description"],
               images: data["images"] !=null
                 ?List<String>.from(data["images"])
             :[],
             creationAt: data ["creationAt"],
             updatedAt: data["updatedAt"],
             category: data["category"]!=null
             ? ProductCategory(
             id: data["category"]["id"],
             name: data["category"]["name"],
             slug: data["category"]["slug"],
             image: data["category"]["image"],
             creationAt: data["category"]["creationAt"],
             updatedAt: data["category"]["updatedAt"],
             )
            : null,
             );}).toList();
     });

}

//clear wishlist

Future<void> clearWishList()async{
     final snapshot = await wishListRef.get();
     final batch = firestore.batch();

     for (final doc in snapshot.docs){
       batch.delete(doc.reference);
     }
     await batch.commit();
}
}