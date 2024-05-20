import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/ui/product_details.dart';

class AllProductShow extends StatelessWidget {
  final List products;
  AllProductShow({super.key, required this.products});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('E-Commerce'),centerTitle: true,),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 40,mainAxisSpacing: 30),
          itemBuilder: (context, index) {
        var product = products[index];
return GestureDetector(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: products[index]),));
  },
  child: Container(

    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              offset: const Offset(0,5),
              spreadRadius: 5,
              blurRadius: 5
          )
        ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
  AspectRatio(
      aspectRatio: 2,
      child: Image.network(product['product-image'][0],fit: BoxFit.cover,)),
        const SizedBox(height: 8,),
        Text(product['product-name'],style: Theme.of(context).textTheme.titleMedium,),
        Text('\$${product['product-price'].toString()}',style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red),),
      ],
    ),
  ),
);

          },),
    );
  }
}
