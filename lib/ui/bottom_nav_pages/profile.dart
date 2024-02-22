import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/main.dart';
import 'package:flutter_e_commerce/ui/bottom_nav_controller.dart';
import 'package:flutter_e_commerce/ui/bottom_nav_pages/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _phoneController;
  
  setDataToTextField(data){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _nameController =TextEditingController(text: data['name']),
        ),
        SizedBox(height: 15,),
        TextFormField(
          controller: _phoneController = TextEditingController(text: data['phone']),
        ),
        SizedBox(height: 15,),
        TextFormField(
          controller: _ageController = TextEditingController(text: data['age']),
        ),
        SizedBox(height: 25,),
        ElevatedButton(onPressed: (){
          updateData();
          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavController(),));
        }, child: Text('Update Data'))
      ],
    );
  }

  updateData(){
      CollectionReference _collectionReference = FirebaseFirestore.instance.collection('users-form-data');
      var name = _nameController?.text.trim();
      var phone = _phoneController?.text.trim();
      var age = _ageController?.text.trim();
      _nameController?.clear();
      _phoneController?.clear();
      _ageController?.clear();
      return _collectionReference.doc(FirebaseAuth.instance.currentUser!.email).update({
        'name':name,
        'phone': phone,
        'age': age,

      }).then((value) => Fluttertoast.showToast(msg: 'Update Successfully',backgroundColor: Colors.green));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users-form-data').doc(FirebaseAuth.instance.currentUser?.email).snapshots(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                if(data == null)
                  {
                    return Center(child: CircularProgressIndicator(),); // avoid short time error for fetch data from firestore
                  }
                return setDataToTextField(data);
              },
            ),
          ),
        ),
    );
  }
}

