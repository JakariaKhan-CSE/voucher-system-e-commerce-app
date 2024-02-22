import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../ui/user_form.dart';

class RegistrationLogic extends ChangeNotifier{
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool secure = true;

  changeSign(){
    secure = !secure;
    print('Call secure, value: ${secure}');
    notifyListeners();
  }
  Future<void> signUp(BuildContext context)async{

    try{

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text
      );

      var authCredential = userCredential.user;


      if(authCredential!.uid.isNotEmpty)
      {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>UserForm()));
      }
      else{
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    }on FirebaseAuthException catch(e)
    {
      if(e.code == 'weak-password')
      {
        Fluttertoast.showToast(msg: "The password provided is too weak");
      }else if(e.code == 'email-already-in-use')
      {
        Fluttertoast.showToast(msg: "The account already exists for that email");
      }
    }
    catch(e)
    {
      // print('Eror Occureed>>> is: ${e}');
    }
    notifyListeners();
  }
}