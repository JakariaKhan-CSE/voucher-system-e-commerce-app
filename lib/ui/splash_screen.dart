import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/const/AppColors.dart';
import 'package:flutter_e_commerce/ui/login_Screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>const LoginScreen())));
    super.initState();


  }
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
          Text("E-Commerce App", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),),
            SizedBox(height: 20,),
            CircularProgressIndicator(color: Colors.white,)
        ],),
      )),
    );
  }
}
