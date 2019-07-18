import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foresight/util.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Colors.transparent,
      child: FlipCard(
       
        back: Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(product.image_url),
            ),
          ),
        ),
        front: Container(
          color: Colors.blue,
          height: 200,
        ),
      ),
    );
  }
}
