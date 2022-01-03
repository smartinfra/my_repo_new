import 'package:flutter/material.dart';
import 'package:sensor_viewer/adapter/grid_shop_product_adapter.dart';
import 'package:sensor_viewer/data/dummy.dart';
import 'package:sensor_viewer/data/my_colors.dart';
import 'package:sensor_viewer/model/shop_category.dart';
import 'package:sensor_viewer/model/shop_product.dart';
import 'package:toast/toast.dart';

class ShoppingProductGridRoute extends StatefulWidget {
  ShoppingProductGridRoute();

  @override
  ShoppingProductGridRouteState createState() =>
      new ShoppingProductGridRouteState();
}

class ShoppingProductGridRouteState extends State<ShoppingProductGridRoute> {
  BuildContext context;
  void onItemClick(int index, ShopCategory obj) {
    Toast.show("Product " + index.toString() + "clicked", context,
        duration: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    List<ShopProduct> items = Dummy.getShoppingProduct();
    return Scaffold(
      backgroundColor: MyColors.grey_10,
      appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: MyColors.primary,
          title: Text("Products", style: TextStyle(color: MyColors.grey_10)),
          leading: IconButton(
            icon: Icon(Icons.menu, color: MyColors.grey_10),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart, color: MyColors.grey_10),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert, color: MyColors.grey_10),
              onPressed: () {},
            ), // overflow menu
          ]),
      body: GridShopProductAdapter(items, onItemClick).getView(),
    );
  }
}