import 'package:flutter/material.dart';
import 'shop.dart';
import 'shop_categories.dart';
import 'TIBSappbar.dart';

void main() {
  runApp(MaterialApp(
    home: MyCategories(),
  ));
}

class MyCategories extends StatefulWidget {
  const MyCategories({super.key});

  // final String categoryId;

  // const MyCategories({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<MyCategories> createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: prefer_const_constructors
        body: FutureBuilder(
            future: getCategories(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                // return Center(child: Text("some data here"));
                var items = data.data as List<Category>;
                return Column(children: [
                  Center(
                    child: Text(
                      'Select a Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      1.0), //Needed to avoid bottom overflow

                          itemCount: items == null ? 0 : items.length,
                          itemBuilder: (context, index) {
                            Category item = items[index];
                            return GridTile(
                              child: GestureDetector(
                                onTap: () {
                                  print("clicked");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyShop(
                                              categoryId: item.id.toString())));
                                },
                                child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 8),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0,
                                        ),
                                      ),
                                    )),
                              ),
                            );
                          }))
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
