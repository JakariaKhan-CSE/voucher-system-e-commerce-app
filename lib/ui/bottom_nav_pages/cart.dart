import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/widget/another_fetch_data.dart';
class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: SafeArea(
        child: ProductList(collectionName: 'users-cart-item', emptyText: 'No Cart Item Here')
      ),
    );
  }
}


