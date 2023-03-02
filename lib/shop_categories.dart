import 'dart:io';
import 'package:dio/dio.dart';
import 'config.dart';

//this is the function used to pull products
Future<List<Category>> getCategories() async {
  List<Category> data = <Category>[];

  try {
    //Neeed to update this url as woocommerce has changed it
    String url =
        "${Config.url}${Config.productURL}/categories?consumer_key=${Config.key}&consumer_secret=${Config.secret}";

    var response = await Dio().get(
      url,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      //whatever you get in e, pass it to fromJson function and then convert the
      //return to a new list

      data = (response.data as List).map((e) => Category.fromJson(e)).toList();
    }
  } on DioError catch (e) {}

  return data;
}

class Category {
  late int id;
  late String name;
  late String description;
  late String image;

  Category({required this.id, required this.name, required this.image});

//This function takes one arguemnet which is json data for one
//product from the api, passed to this function in getProducts
//function fromJson is an implicit fuctuin of a class in flutter,
  ///it takes a json object as arguement
  /// it does not need a return statement as it sets the
  /// elements from the product to the assigned value
  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // image = json['image'];
  }
}
