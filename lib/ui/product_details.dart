import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../const/AppColors.dart';

class ProductDetails extends StatefulWidget {
  var product;
  ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Future addCart()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var current_user = _auth.currentUser;
    CollectionReference _collectionReference  = FirebaseFirestore.instance.collection('users-cart-item');
    return _collectionReference.doc(current_user!.email).collection('items').doc().set({
          "name":widget.product['product-name'],
          "price":widget.product['product-price'], // change product-price to productPrice
          "image":widget.product['product-image']
    }).then((value) => Fluttertoast.showToast(msg: 'Added to Cart Successfully',backgroundColor: Colors.green));
  }
  Future addFavourite()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var current_user = _auth.currentUser;
    CollectionReference _collectionReference  = FirebaseFirestore.instance.collection('users-favourite-item');
    return _collectionReference.doc(current_user!.email).collection('items').doc().set({
      "name":widget.product['product-name'],
      "price":widget.product['product-price'], // change product-price to productPrice will error occur
      "image":widget.product['product-image']
    }).then((value) => Fluttertoast.showToast(msg: 'Added to Favourite Successfully',backgroundColor: Colors.green));
  }
  var _dotPosition = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.deep_orange,
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users-favourite-item').doc(FirebaseAuth.instance.currentUser?.email).collection('items').
            where('name',isEqualTo: widget.product['product-name']).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.data == null)
                {
                  return Text("");
                }
              return CircleAvatar(
                backgroundColor: AppColors.deep_orange,
                child: IconButton(onPressed: (){
                 snapshot.data?.docs.length==0?addFavourite():Fluttertoast.showToast(msg: 'Already Added Favourite');
                },icon: snapshot.data?.docs.length==0?Icon(Icons.favorite_border_outlined,color: Colors.white,):Icon(Icons.favorite_outlined)),
              );
            },

          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(aspectRatio: 16/9,
                //map<Widget>(v.v otherwise error)
                child: CarouselSlider(items: widget.product['product-image'].map<Widget>((item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    decoration: BoxDecoration(
                        image:  DecorationImage(
                            image: NetworkImage(item),
                            fit: BoxFit.fitWidth
                        )
                    ),
                  ),
                )).toList(),
                  options: CarouselOptions(
          
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 8), // 8 second por por item change hobe automatically
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.8,
          
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _dotPosition = index;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: DotsIndicator(dotsCount: widget.product.length==0?1:widget.product['product-image'].length,
                  position: _dotPosition,
                  decorator: DotsDecorator(
                    activeColor: AppColors.deep_orange,
                    color: Colors.grey,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Text(widget.product['product-name'],style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text('\$${widget.product['product-price']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              SizedBox(height: 15,),
              Text(widget.product['product-description'],textAlign: TextAlign.justify,),
              SizedBox(height: 15,),
              SizedBox(
                width: double.infinity/1.2,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.deep_orange,),onPressed: ()=>addCart(), child: Text('Add to Cart',style: TextStyle(color: Colors.white),)))
            ],
          ),
        ),
      ),
    );
  }
}
