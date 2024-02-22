import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/business%20logic/all%20logic%20here.dart';
import 'package:flutter_e_commerce/ui/login_Screen.dart';
import 'package:flutter_e_commerce/ui/user_form.dart';
import 'package:flutter_e_commerce/widget/custom%20button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../business logic/registration logic.dart';
import '../const/AppColors.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  @override
  Widget build(BuildContext context) {
    final _RegLogic = Provider.of<RegistrationLogic>(context,listen: true);
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 60),
            child: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 34),),
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
                      child: Text('Welcome Buddy!',style: TextStyle(color: AppColors.deep_orange, fontWeight: FontWeight.bold, fontSize: 30),),
                    ),
                    Text('Glad to see you my buddy!',style: TextStyle(color: Colors.grey,fontSize: 15,letterSpacing: 1.1),),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: _RegLogic.emailcontroller,
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
                      controller: _RegLogic.passwordcontroller,
                      obscureText:_RegLogic.secure,

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

                          _RegLogic.changeSign();
                        },icon:_RegLogic.secure? Icon(Icons.remove_red_eye): Icon( Icons.remove_red_eye_outlined)),


                      ),
                    ),
                    SizedBox(height: 50,),
                    CustomButton('CONTINUE', ()=>context.read<RegistrationLogic>().signUp(context), context),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have accoun?",style: TextStyle(color: Colors.grey),),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                        }, child: Text('Sign In',style: TextStyle(color: AppColors.deep_orange,fontWeight: FontWeight.bold),))
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

