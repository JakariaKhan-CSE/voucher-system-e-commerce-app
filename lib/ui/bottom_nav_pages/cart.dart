import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/widget/another_fetch_data.dart';
import 'package:flutter_e_commerce/widget/fetch%20data.dart';
class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: ProductList(collectionName: 'users-cart-item', emptyText: 'No Cart Item Here')
      ),
    );
  }
}


