import 'package:flutter/material.dart';
import 'package:furniture_shop/models/product.dart';
import 'package:furniture_shop/screens/product_details.dart';

import '../constants.dart';
import '../size_config.dart';

class Products extends StatelessWidget {
  final List<Product> products;
  const Products({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    final productWidgets = List.generate(
      products.length,
      (index) => ProductCard(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ProductDetails(product: products[index]);
              },
            ),
          );
        },
        product: products[index],
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended For You",
            style: TextStyle(
              fontSize: defaultSize * 1.6,
              fontWeight: FontWeight.bold,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: productWidgets.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.693,
              crossAxisCount:
                  SizeConfig.orientation == Orientation.portrait ? 2 : 4,
            ),
            itemBuilder: (context, index) {
              return productWidgets[index];
            },
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  ProductCard({
    @required this.product,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(
          defaultSize * 2.0,
        ),
        child: SizedBox(
          width: defaultSize * 20.5,
          child: AspectRatio(
            aspectRatio: 0.83,
            child: Stack(
              children: [
                ClipPath(
                  clipper: ProductClipper(),
                  child: Container(
                    color: kSecondaryColor,
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: defaultSize * 1.6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                          color: kTextColor.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Hero(
                    tag: product.id,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/spinner.gif",
                      image: product.image,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final height = size.height;
    final width = size.width;
    final cornerSize = 30.0;
    path.lineTo(0, height - cornerSize);
    path.quadraticBezierTo(0, height, cornerSize, height);
    path.lineTo(width - cornerSize, height);
    path.quadraticBezierTo(width, height, width, height - cornerSize);
    path.lineTo(width, cornerSize);
    path.quadraticBezierTo(width, 0, width - cornerSize, 0);
    path.lineTo(cornerSize, 0);
    path.quadraticBezierTo(0, 0, 0, cornerSize);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return this != oldClipper;
  }
}
