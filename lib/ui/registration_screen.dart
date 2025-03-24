import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/ui/login_Screen.dart';
import 'package:flutter_e_commerce/widget/custom%20button.dart';
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
    final RegLogic = Provider.of<RegistrationLogic>(context,listen: true);
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20,top: 60),
            child: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 34),),
          ),
          const SizedBox(height: 30,),
          Expanded(
            child: Container(

              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(

                  children: [
                    const Padding(
                      padding: EdgeInsets.only( top: 30),
                      child: Text('Welcome Buddy!',style: TextStyle(color: AppColors.deep_orange, fontWeight: FontWeight.bold, fontSize: 30),),
                    ),
                    const Text('Glad to see you my buddy!',style: TextStyle(color: Colors.grey,fontSize: 15,letterSpacing: 1.1),),
                    const SizedBox(height: 30,),
                    TextFormField(
                      controller: RegLogic.emailcontroller,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(

                              decoration: BoxDecoration(
                                  color: AppColors.deep_orange,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Icon(Icons.email_outlined),
                            ),
                          ),
                          hintText: "Enter your Email",
                          border: InputBorder.none,
                          label: const Text('Email')
                      ),
                    ),

                    TextFormField(
                      controller: RegLogic.passwordcontroller,
                      obscureText:RegLogic.secure,

                      decoration: InputDecoration(


                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(

                            decoration: BoxDecoration(
                                color: AppColors.deep_orange,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Icon(Icons.lock),
                          ),
                        ),
                        hintText: "Enter your Password",
                        border: InputBorder.none,
                        label: const Text('Password'),
                        suffixIcon: IconButton(onPressed: (){

                          RegLogic.changeSign();
                        },icon:RegLogic.secure? const Icon(Icons.remove_red_eye): const Icon( Icons.remove_red_eye_outlined)),


                      ),
                    ),
                    const SizedBox(height: 50,),
                    CustomButton('CONTINUE', ()=>context.read<RegistrationLogic>().signUp(context), context),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have accoun?",style: TextStyle(color: Colors.grey),),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
                        }, child: const Text('Sign In',style: TextStyle(color: AppColors.deep_orange,fontWeight: FontWeight.bold),))
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

