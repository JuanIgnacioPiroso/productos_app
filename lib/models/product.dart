import 'dart:convert';

Map<String, Product> productFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Product>(k, Product.fromJson(v)));

String productToJson(Map<String, Product> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Product {
    Product({
        required this.available,
        required this.name,
        this.picture,
        required this.price, required imageUrl, required String id, required title, required description,
    });

    bool available;
    String name;
    String? picture;
    double price;
    String? id;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(), 
        description: null, 
        id: '', 
        imageUrl: null, 
        title: null,
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
    };
}