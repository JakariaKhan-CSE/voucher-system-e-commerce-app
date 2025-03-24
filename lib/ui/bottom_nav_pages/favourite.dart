import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/widget/fetch%20data.dart';
class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: fetchProduct("users-favourite-item", "No Favourite Item here"),
      ),
    );
  }
}


