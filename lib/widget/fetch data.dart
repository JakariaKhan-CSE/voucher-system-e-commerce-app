import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
Widget fetchProduct(collectionName,String emptyText){
  int totalamount = 0;
  int total;
  bool hasVoucher = false;
  double discount = 0.0;

  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection(collectionName).doc(FirebaseAuth.instance.currentUser?.email).collection('items').snapshots(),
    builder: (context, snapshot) {
      if(snapshot.data?.docs.isEmpty)
      {
        return Center(child: Text(emptyText,style: Theme.of(context).textTheme.titleLarge,));
      }
      if(snapshot.hasError)
      {
        return const Center(child: Text('Something went wrong'),);
      }
      if(snapshot.connectionState==ConnectionState.waiting)
      {
        return const Center(child: CircularProgressIndicator(),);
      }
      // Calculate total amount
      totalamount = 0;
      for (var doc in snapshot.data!.docs) {
        totalamount += int.parse(doc['price'].toString());
      }
      return Column(
        children: [
          Expanded(child:
          ListView.builder(itemCount: snapshot.data?.docs.length,itemBuilder: (context, index) {
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
                      Text('\$${documentSnapshot['price'].toString()}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.deepOrange),),
                      const SizedBox(width: 10,),
                      IconButton(onPressed: (){
                        FirebaseFirestore.instance.collection(collectionName).doc(FirebaseAuth.instance.currentUser?.email).collection('items').doc(documentSnapshot.id).delete();
                      }, icon: const Icon(Icons.delete,color: Colors.red,))
                    ],
                  ),
                ),


              ),
            );
          },)),

        ],
      );
    },
  );
}

void generateVoucher() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var currentUser = auth.currentUser;

  if (currentUser != null) {
    CollectionReference vouchersCollection = FirebaseFirestore.instance.collection('vouchers');
    String voucherCode = generateRandomVoucherCode();

    await vouchersCollection.doc(currentUser.email).set({
      "code": voucherCode,
      "discountPercentage": 10,
      "used": false,
    });

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('Voucher generated: $voucherCode'),
    //   backgroundColor: Colors.green,
    // ));
  }
}

String generateRandomVoucherCode() {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return String.fromCharCodes(Iterable.generate(8, (_) => characters.codeUnitAt((characters.length * (DateTime.now().microsecond / 1000000)).floor())));
}
