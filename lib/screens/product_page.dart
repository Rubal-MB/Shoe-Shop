import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoe_shop/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/constants.dart';
import 'package:shoe_shop/widgets/custom_actionbar.dart';
import 'package:shoe_shop/widgets/image_swipe.dart';
import 'package:shoe_shop/widgets/product_size.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = '0';

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection('Cart')
        .doc(widget.productId)
        .set({'size': _selectedProductSize});
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection('Saved')
        .doc(widget.productId)
        .set({'size': _selectedProductSize});
  }

  final SnackBar _snackBar =
      SnackBar(content: Text('Product Added To The Cart'));

  final SnackBar _snackBar1 =
      SnackBar(content: Text('Product Added To The Saved'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // Firebase Document data map
                Map<String, dynamic> documentData = snapshot.data.data();

                // storing the images in form of list
                List imageList = documentData['images'];
                List productSizes = documentData['size'];

                //setting an initial size
                _selectedProductSize = productSizes[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(imageList: imageList),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24.0,
                        top: 24.0,
                        bottom: 4.0,
                        right: 24.0,
                      ),
                      child: Text(
                        '${documentData['name']}',
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        '\$${documentData['price']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        '${documentData['desc']}' ?? 'Descriptions',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        'Select Size',
                        style: Constants.regularDarkHeading,
                      ),
                    ),
                    ProductSize(
                      productSizes: productSizes,
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                                await _addToSaved();
                                Scaffold.of(context).showSnackBar(_snackBar1);
                              },
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  color: Color(0xffDCDCDC),
                                  borderRadius: BorderRadius.circular(12.0)),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/tab-bookmark.png',
                                ),
                                height: 22.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addToCart();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 60.0,
                                margin: EdgeInsets.only(
                                  left: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasTitle: false,
            hasBackground: false,
            hasBackArrow: true,
          )
        ],
      ),
    );
  }
}
