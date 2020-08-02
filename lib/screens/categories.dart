import 'package:flutter/material.dart';
import 'package:furniture_shop/models/categories.dart';

import '../constants.dart';
import '../size_config.dart';

class Categories extends StatelessWidget {
  final List<Category> categories;
  const Categories({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Browse by Categories",
            style: TextStyle(
              fontSize: defaultSize * 1.6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                categories.length,
                (index) => CategoryCard(
                  category: categories[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({
    @required this.category,
  });

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    return Padding(
      padding: EdgeInsets.all(
        defaultSize * 2.0,
      ),
      child: SizedBox(
        width: defaultSize * 20.5,
        child: AspectRatio(
          aspectRatio: kCategoryCardAspectRatio,
          child: Stack(
            children: [
              ClipPath(
                clipper: CategoryClipper(),
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
                      category.title,
                      style: TextStyle(
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${category.numOfProducts}+ products",
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
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/spinner.gif",
                  image: category.image,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryClipper extends CustomClipper<Path> {
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
    path.lineTo(cornerSize, cornerSize * 0.75);
    path.quadraticBezierTo(0, cornerSize, 0, cornerSize * 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return this != oldClipper;
  }
}
