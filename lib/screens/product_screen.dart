import 'package:flutter/material.dart';
import 'package:productos_app/widgets/product_image.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: Column(

          children: [

            Stack(

              children: [

                ProductImage(),
              ],
            )
          ],
        ),
      )
    );
  }
}