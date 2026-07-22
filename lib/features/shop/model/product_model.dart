class ProductModel {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  ProductCategory? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;

  ProductModel({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];

    category = json['category'] != null
        ? ProductCategory.fromJson(json['category'])
        : null;

    images = json['images'] != null
        ? List<String>.from(json['images'])
        : [];

    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['price'] = price;
    data['description'] = description;

    if (category != null) {
      data['category'] = category!.toJson();
    }

    data['images'] = images;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
  //fire base operations
// to convert to firebase object

  Map<String,dynamic>toMap(){
    return {
      'id':id,
      'title':title,
      'slug':slug,
      'price':price,
      'description':description,
      'category':category?.toMap(),
      'images':images,
      'creationAt':creationAt,
      'updateAt':updatedAt,


    };
  }
  factory ProductModel.fromMap(Map<String,dynamic>map){
    return ProductModel(
        id: map['id'],
        title: map['title'],
        slug: map['slug'],
        price: map['price'],
        description:map['description'],
        category: map['category'] !=null
            ? ProductCategory.fromMap(
            Map<String,dynamic>.from(map['category'])
        )
            :null,
        images: map['images']!=null
            ?List<String>.from(map['images']):[],
        creationAt: map['creationAt'],
        updatedAt: map['updateAt']
    );
  }

}

class ProductCategory {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  ProductCategory({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
  Map<String,dynamic>toMap(){
    return{

      'id':id,
      'name':name,
      'slug':slug,
      'image':image,
      'creationAt':creationAt,
      'updateAt':updatedAt,


    };
  }
  factory ProductCategory.fromMap(Map<String,dynamic>map){
    return ProductCategory(
        id: map['id'],
        name:map['name'],
        slug: map['slug'],
        image: map['image'],
        creationAt:map['creationAt'],
        updatedAt: map['updateAt']
    );
  }
}