import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/business%20logic/all%20logic%20here.dart';
import 'package:flutter_e_commerce/ui/bottom_nav_pages/cart.dart';
import 'package:flutter_e_commerce/ui/bottom_nav_pages/favourite.dart';
import 'package:flutter_e_commerce/ui/bottom_nav_pages/home.dart';
import 'package:flutter_e_commerce/ui/bottom_nav_pages/profile.dart';

import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
class BottomNavController extends StatefulWidget {

 const BottomNavController({super.key,});

  @override
  State<BottomNavController> createState() => _HomePageState();
}

class _HomePageState extends State<BottomNavController> {
  int x=0;

  final _pages = [const Home(),const Favourite(),const Cart(),const Profile()];

  @override
  Widget build(BuildContext context) {
    final _logic = Provider.of<BusinessLogic>(context,listen: true);

    return Scaffold(
      appBar: AppBar(title: Text("E-Commerce"),centerTitle: true,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _logic.currentIndex,
        elevation: 5,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined),label: "Favourite",backgroundColor: Colors.white),
          BottomNavigationBarItem(
   icon: badges.Badge(
    position: badges.BadgePosition.topEnd(top: -10, end: -12),
     badgeContent: Text(_logic.cartItemCount.toString()),
     child: Icon(Icons.add_shopping_cart),
     badgeStyle: badges.BadgeStyle(
       badgeColor: Colors.blue
     ),
   ),
              // icon: Icon(Icons.add_shopping_cart),
              label: "Cart",backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Person",backgroundColor: Colors.white),
        ],
        onTap: (index){
          _logic.changeIndex(index);
        },
      ),
      body: _pages[_logic.currentIndex],
    );
  }
}
