import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_e_commerce/business%20logic/all%20logic%20here.dart';
import 'package:flutter_e_commerce/ui/bottom_nav_controller.dart';
import 'package:provider/provider.dart';




class OrderSuccessfull extends StatefulWidget {
  const OrderSuccessfull({super.key});

  @override
  State<OrderSuccessfull> createState() => _OrderSuccessfullState();
}

class _OrderSuccessfullState extends State<OrderSuccessfull> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>const BottomNavController())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<BusinessLogic>(context,listen: true).currentIndex = 0;
    return Scaffold(
      body: Center(
        child: Animate(
          effects: const [FadeEffect(duration: Duration(milliseconds: 1000)),ScaleEffect(duration: Duration(milliseconds: 1000))],
          child: const Text('Order Successfull',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.indigo),),
        ),
      ),
    );
  }
}
