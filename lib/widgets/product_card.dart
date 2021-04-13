import 'package:flutter/material.dart';
import 'package:shoe_shop/constants.dart';
import 'package:shoe_shop/screens/product_page.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productId;

  const ProductCard({this.imageUrl, this.title, this.price, this.productId});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                productId: productId,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  '$imageUrl',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Constants.regularHeading,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        // Text('name: ${document.data()['name']}'),
      ),
    ));
  }
}
