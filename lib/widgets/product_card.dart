import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 50, top: 30),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            _BackgroundImage(product.picture),

            _ProductDetails(
              title: product.name,
              description: product.id!,
            ),

            Positioned (
              top: 0,
              right: 0,
              child: _PriceTag(product.price),
              ),

              
              if(!product.available)
              Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable()
              )

        ]),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10,
      )
      

    ]
  );
}

class _NotAvailable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {

  final double price;

  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(



      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),

      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$price', style: const TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  final String title;
  final String description;

  const _ProductDetails({
    required this.title, 
    required this.description
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              title, 
              style: const TextStyle(
                color: Colors.white, 
                fontSize: 20, 
                fontWeight: 
                FontWeight.bold
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                ),
            
            
            Text(description, style: const TextStyle(color: Colors.white, fontSize: 15),),
          ],
        ),
    
    
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),topRight: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10,
      )
      

    ]
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? imageUrl;

  const _BackgroundImage(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      // ignore: sized_box_for_whitespace
      child: Container(
    
        width: double.infinity,
        height: 400,
        child: imageUrl == null
        ? const Image(
          image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover,
          )
        : FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(imageUrl!),
          fit: BoxFit.cover,
           ),
      ),
    );
  }
}