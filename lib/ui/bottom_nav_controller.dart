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
    final logic = Provider.of<BusinessLogic>(context,listen: true);

    return Scaffold(
      appBar: AppBar(title: const Text("E-Commerce"),centerTitle: true,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: logic.currentIndex,
        elevation: 5,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",backgroundColor: Colors.white),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined),label: "Favourite",backgroundColor: Colors.white),
          BottomNavigationBarItem(
   icon: badges.Badge(
    position: badges.BadgePosition.topEnd(top: -17, end: -15),
     badgeContent: Text(logic.cartItemCount.toString()),
     badgeStyle: const badges.BadgeStyle(
       badgeColor: Colors.blue
     ),
     child: const Icon(Icons.add_shopping_cart),
   ),
              // icon: Icon(Icons.add_shopping_cart),
              label: "Cart",backgroundColor: Colors.white),
          const BottomNavigationBarItem(icon: Icon(Icons.person),label: "Person",backgroundColor: Colors.white),
        ],
        onTap: (index){
          logic.changeIndex(index);
        },
      ),
      body: _pages[logic.currentIndex],
    );
  }
}
