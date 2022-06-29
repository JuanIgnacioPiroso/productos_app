import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'flutter-varios-dfff3-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService(){

    loadProducts();


  }

  Future<List<Product>> loadProducts()async {

    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {

      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);

    });

    isLoading = false;
    notifyListeners();

    return products;

  }

  Future  saveOrCreateProduct(Product product)async{

    isSaving = true;
    notifyListeners();

    if (product.id == null) {

      await createProduct(product);

    } else {

      await updateProduct(product);
    }
      
    



    isSaving = false;
    notifyListeners();


  }

  Future<String> updateProduct(Product product) async {


    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    // ignore: unused_local_variable
    final resp = await http.put(url, body: json.encode(product.toJson()));
    final decodedData = resp.body;

    // ignore: todo
    //TODO: Actualizar el listado de productos

    final index = products.indexWhere((p) => p.id == product.id);
    products[index] = product;


    return product.id!;

  }

   Future<String> createProduct(Product product) async {


    final url = Uri.https(_baseUrl, 'products.json');
    // ignore: unused_local_variable
    final resp = await http.post(url, body: json.encode(product.toJson()));
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    products.add(product);

    return product.id!;

  }

  void updateSelectedProductImage(String path){


    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();


  }
  


}