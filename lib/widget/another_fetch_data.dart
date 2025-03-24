import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/ui/complete_order_animation.dart';

class ProductList extends StatefulWidget {
  final String collectionName;
  final String emptyText;

  const ProductList({super.key, required this.collectionName, required this.emptyText});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int totalAmount = 0;
  bool hasVoucher = false;
  int discount = 0;

  @override
  void initState() {
    super.initState();

    checkVoucher();

  }

  void checkVoucher() async {

    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot voucherDoc = await FirebaseFirestore.instance
          .collection('vouchers')
          .doc(currentUser.email)
          .get();
      if (voucherDoc.exists && !voucherDoc['used']) {
        print('voucher ase');
        setState(() {
          hasVoucher = true;
          discount = voucherDoc['discountPercentage'];

          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text('Voucher used and discount applied!'),
          //   backgroundColor: Colors.green,
          // ));
        });

      }
      else{
        print('voucher nei');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(widget.collectionName)
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('items')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.data?.docs.isEmpty) {
          return Center(
            child: Text(
              widget.emptyText,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        // Calculate total amount
        totalAmount = 0;
        for (var doc in snapshot.data!.docs) {
          totalAmount += int.parse(doc['price'].toString());
        }

        double finalAmount = 0.0;

        if (hasVoucher) {
          finalAmount = totalAmount * ((100 - discount) / 100);

        } else {
          finalAmount = totalAmount.toDouble();

        }

        return Column(
          children: [
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.network(documentSnapshot['image'][0]),
                      ),
                      title: Text(documentSnapshot['name']),
                      trailing: FittedBox(
                        child: Row(
                          children: [
                            Text(
                              '\$${documentSnapshot['price'].toString()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.deepOrange,
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection(widget.collectionName)
                                    .doc(FirebaseAuth.instance.currentUser?.email)
                                    .collection('items')
                                    .doc(documentSnapshot.id)
                                    .delete();
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // if (hasVoucher)
                  //   Text(
                  //     'Voucher Applied: -$discount%',
                  //     style:
                  //     const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  //   ),
                  Text('Total amount: \$$totalAmount'),
                  Text(
                    'Discount: \$${(totalAmount - finalAmount.toInt())}',
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Text('Final amount: \$$finalAmount'),
                  TextButton(
                    onPressed: () async {
                      if (totalAmount >= 50000) {
                        await generateVoucher();
                      }
                      if(hasVoucher)
                        {
                          await useVoucher();
                        }
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Order confirmed!'),
                        backgroundColor: Colors.green,
                      ));
                      deleteAllDocumentsInItemsCollection();

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OrderSuccessfull(),));
                    },
                    child: const Text('Order Confirm'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
  void deleteAllDocumentsInItemsCollection() async {
    var itemsCollectionRef = FirebaseFirestore.instance
        .collection(widget.collectionName)
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('items');

    var snapshots = await itemsCollectionRef.get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> generateVoucher() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;

    if (currentUser != null) {
      CollectionReference vouchersCollection =
      FirebaseFirestore.instance.collection('vouchers');
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

  Future<void> useVoucher() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;

    if (currentUser != null) {
      DocumentReference voucherDoc =
      FirebaseFirestore.instance.collection('vouchers').doc(currentUser.email);
      await voucherDoc.update({
        "used": true,
      });

      setState(() {
        hasVoucher = false;
        discount = 0;
      });

      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('Voucher used and discount applied!'),
      //   backgroundColor: Colors.green,
      // ));
    }
  }

  String generateRandomVoucherCode() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(
        8,
            (_) => characters.codeUnitAt(
            (characters.length * (DateTime.now().microsecond / 1000000)).floor())));
  }
}
