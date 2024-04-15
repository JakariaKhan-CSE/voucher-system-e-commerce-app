import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_e_commerce/const/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_e_commerce/ui/bottom_nav_controller.dart';
import 'package:flutter_e_commerce/ui/registration_screen.dart';
import 'package:flutter_e_commerce/ui/user_form.dart';
import 'package:flutter_e_commerce/widget/custom%20button.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../business logic/all logic here.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _businessLogic = Provider.of<BusinessLogic>(context,listen: true); // aita aikhane kaj korbe na

  @override
  Widget build(BuildContext context) {
    final _LogLogic = Provider.of<BusinessLogic>(context,listen: true); // eita eikhane sara kaj korbe na
    // final _LogLogic = Provider.of<BusinessLogic>(context,listen: true);
    return Scaffold(
backgroundColor: AppColors.deep_orange,
body: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.only(left: 20,top: 60),
      child: Text('Sign In',style: TextStyle(color: Colors.white, fontSize: 34),),
    ),
    SizedBox(height: 30,),
    Expanded(
      child: Container(

        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(

            children: [
              Padding(
                padding: const EdgeInsets.only( top: 30),
                child: Text('Welcome Back',style: TextStyle(color: AppColors.deep_orange, fontWeight: FontWeight.bold, fontSize: 30),),
              ),
              Text('Glad to see you back my buddy!',style: TextStyle(color: Colors.grey,fontSize: 15,letterSpacing: 1.1),),
              SizedBox(height: 30,),
              TextFormField(
                controller: _LogLogic.emailcontroller,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(

                      decoration: BoxDecoration(
                        color: AppColors.deep_orange,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.email_outlined),
                    ),
                  ),
                  hintText: "Enter your Email",
                  border: InputBorder.none,
                  label: Text('Email')
                ),
              ),
              TextFormField(
                controller: _LogLogic.passwordcontroller,
                obscureText: _LogLogic.secure,
                decoration: InputDecoration(


                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(

                        decoration: BoxDecoration(
                            color: AppColors.deep_orange,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(Icons.lock),
                      ),
                    ),
                    hintText: "Enter your Password",
                    border: InputBorder.none,
                    label: Text('Password'),
                  suffixIcon: IconButton(onPressed: (){
                   _LogLogic.changeSign();
                  },icon:Icon( Icons.remove_red_eye_outlined)),


                ),
              ),
              SizedBox(height: 50,),
              CustomButton('SIGN IN', ()=>_LogLogic.signIn(context), context),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have accoun?",style: TextStyle(color: Colors.grey),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>RegistrationScreen()));
                  }, child: Text('Sign Up',style: TextStyle(color: AppColors.deep_orange,fontWeight: FontWeight.bold),))
                ],
              )



            ],
          ),
        ),
      ),
    )
  ],
),
    );
  }
}
