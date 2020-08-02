import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/constants.dart';
import 'package:furniture_shop/models/product.dart';
import 'package:furniture_shop/size_config.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    TextStyle lightTextStyle = TextStyle(
        color: kTextColor.withOpacity(0.6), fontSize: defaultSize * 1.7);
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/arrow-long-left.svg",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/bag.svg",
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultSize * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category.toUpperCase(),
                      style: lightTextStyle,
                    ),
                    SizedBox(
                      height: defaultSize * 2,
                    ),
                    Text(
                      product.title.split(" ").join(
                            "\n",
                          ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultSize * 3,
                      ),
                    ),
                    Text(
                      "From",
                      style: lightTextStyle,
                    ),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultSize * 2,
                      ),
                    ),
                    SizedBox(
                      height: defaultSize * 10,
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    18,
                  ),
                  topRight: Radius.circular(
                    18,
                  ),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 40 * defaultSize,
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          product.subTitle,
                          style: TextStyle(
                            fontSize: defaultSize * 2.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: defaultSize * 2,
                        ),
                        Text(
                          product.description,
                          style: TextStyle(
                            color: kTextColor.withOpacity(
                              0.7,
                            ),
                            height: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: defaultSize * 7,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              36,
                            ),
                          ),
                          elevation: 0.0,
                          onPressed: () {},
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontSize: defaultSize * 1.6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -6 * defaultSize,
            top: defaultSize * 9.5,
            child: Hero(
              tag: product.id,
              child: FadeInImage.assetNetwork(
                width: defaultSize * 30,
                fit: BoxFit.fitWidth,
                placeholder: "assets/spinner.gif",
                image: product.image,
              ),
            ),
          )
        ],
      ),
    );
  }
}
