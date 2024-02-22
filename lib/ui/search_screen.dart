import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    inputText = value;
                    print(inputText);
                  });
                },
              ),
              Expanded(child: Container(
                child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('products').where('product-name',isGreaterThanOrEqualTo: inputText).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasError)
                    {
                      return Center(child: Text('Something went wrong'),);
                    }
                  if(snapshot.connectionState == ConnectionState.waiting)
                    {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Loading'),
                            SizedBox(height: 10,),
                            CircularProgressIndicator(color: Colors.black,)
                          ],
                        ),
                      );
                    }

                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String,dynamic> data = document.data() as Map<String,dynamic>;
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          title: Text(data['product-name']),
                          leading: Image.network(data['product-image'][0],width: 50,),

                        ),
                      );
                    } ).toList(),
                  );

                },),
              ))
            ],
          ),
        ),
      ),
    );

  }
}
