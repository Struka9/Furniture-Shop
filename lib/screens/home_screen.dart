import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/models/categories.dart';
import 'package:furniture_shop/models/product.dart';
import 'package:furniture_shop/screens/products.dart';
import 'package:furniture_shop/services/fetch_categories.dart';
import 'package:furniture_shop/services/fetch_products.dart';
import 'package:furniture_shop/size_config.dart';

import 'categories.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/menu.svg"),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/scan.svg",
              ),
            ),
          ],
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List<Category>>(
            future: fetchCategories(),
            builder: (context, AsyncSnapshot<List<Category>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Image.asset(
                    "assets/spinner.gif",
                  ),
                );
              }
              return Categories(
                categories: snapshot.data,
              );
            },
          ),
          Divider(
            height: SizeConfig.defaultSize,
          ),
          FutureBuilder<List<Product>>(
            future: fetchProducts(),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Image.asset(
                    "assets/spinner.gif",
                  ),
                );
              }
              return Products(
                products: snapshot.data,
              );
            },
          ),
        ],
      ),
    );
  }
}
