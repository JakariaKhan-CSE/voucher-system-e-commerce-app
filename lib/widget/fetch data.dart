import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
Widget fetchProduct(collectionName,String emptyText){
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection(collectionName).doc(FirebaseAuth.instance.currentUser?.email).collection('items').snapshots(),
    builder: (context, snapshot) {
      if(snapshot.data?.docs.length == 0)
      {
        return Center(child: Text(emptyText,style: Theme.of(context).textTheme.titleLarge,));
      }
      if(snapshot.hasError)
      {
        return Center(child: Text('Something went wrong'),);
      }
      if(snapshot.connectionState==ConnectionState.waiting)
      {
        return Center(child: CircularProgressIndicator(),);
      }
      return ListView.builder(itemCount: snapshot.data?.docs.length,itemBuilder: (context, index) {
        DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Image.network(documentSnapshot['image'][0]),
            ),
            title: Text(documentSnapshot['name']),
            // not using FittedBox, you can get error
            trailing: FittedBox(
              child: Row(
                children: [
                  Text('\$${documentSnapshot['price'].toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.deepOrange),),
                  SizedBox(width: 10,),
                  IconButton(onPressed: (){
                    FirebaseFirestore.instance.collection(collectionName).doc(FirebaseAuth.instance.currentUser?.email).collection('items').doc(documentSnapshot.id).delete();
                  }, icon: Icon(Icons.delete,color: Colors.red,))
                ],
              ),
            ),


          ),
        );
      },);
    },
  );
}