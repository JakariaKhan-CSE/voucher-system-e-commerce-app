
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../ui/bottom_nav_controller.dart';
import '../ui/user_form.dart';


class BusinessLogic extends ChangeNotifier{
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool secure = true;

  changeSign(){
    secure = !secure;
    // print('Call secure, value: ${secure}');
    notifyListeners();
  }
  int currentIndex=0;
  changeIndex(int index){
    currentIndex = index;
    notifyListeners();
  }
  Future<void> signIn(BuildContext context)async{

    try{

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text
      );

      var authCredential = userCredential.user;


      if(authCredential!.uid.isNotEmpty)
      {

        Navigator.pushReplacement(context ,MaterialPageRoute(builder: (_)=>BottomNavController()));
      }
      else{

        Fluttertoast.showToast(msg: "Something is wrong");
      }
    }on FirebaseAuthException catch(e)
    {


      if(e.code == 'user-not-found')
      {

        Fluttertoast.showToast(msg: "User Not Found for this email");
      }else if(e.code == 'wrong-password')
      {

        Fluttertoast.showToast(msg: "Wrong Password");
      }
      else{
        Fluttertoast.showToast(msg: "Unknown error ${e.message?.toString()}");
      }
    }
    catch(e)
    {
      print('Eror Occureed>>> is: ${e}');
    }
    notifyListeners();
  }



}