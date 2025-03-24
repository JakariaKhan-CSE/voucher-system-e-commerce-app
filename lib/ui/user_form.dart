import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/ui/bottom_nav_controller.dart';
import 'package:flutter_e_commerce/widget/custom%20button.dart';
import 'package:flutter_e_commerce/widget/myTextField.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  List<String> gender = ["Male", "Female", "Others"];
  Future<void> _selectDateFromPicker(BuildContext context)async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year-20),
        firstDate: DateTime(DateTime.now().year-30),
        lastDate: DateTime(DateTime.now().year)
    );
    if(picked != null)
      {
        setState(() {
          _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
        });
      }
  }

  sendUserDataDB()async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection("users-form-data");
   return collectionReference.doc(currentUser?.email).set({
     "name": _nameController.text,
     "phone": _phoneController.text,
     "dob": _dobController.text,
     "gender": _genderController.text,
     "age": _ageController.text,
   }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>const BottomNavController()))).catchError((error)=>print("error is $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              const Text("Submit the form to Continue",style: TextStyle(color: Colors.red, fontSize: 22,fontWeight: FontWeight.bold),),
              const Text("We will not share your information with anyone.",style: TextStyle(color: Colors.grey),),
              const SizedBox(height: 40,),
              myTextField("Full Name", _nameController),
              const SizedBox(height: 20,),
              myTextField("Phone Number", _phoneController),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _dobController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Date of Birth",
                  suffixIcon: IconButton(onPressed: ()=>_selectDateFromPicker(context),icon: const Icon(Icons.calendar_month),)
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _genderController,
                readOnly: true,
                decoration: InputDecoration(
                    hintText: "Choose your gender",
                  prefixIcon: DropdownButton<String>(
                    items: gender.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      onTap: (){
                        setState(() {
                          _genderController.text = e;
                        });
                      },
                      );
                    }).toList(),
                    onChanged: (_){

                    },
                  )
                ),
              ),
              const SizedBox(height: 20,),
              myTextField("Age", _ageController),
              const SizedBox(height: 50,),

             CustomButton('Continue', ()=>sendUserDataDB(), context)
              
            ],
          ),
        ),
      ),
    );
  }
}
