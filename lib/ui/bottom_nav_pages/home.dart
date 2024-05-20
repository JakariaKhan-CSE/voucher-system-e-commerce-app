import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/const/AppColors.dart';
import 'package:flutter_e_commerce/ui/all_product_show.dart';
import 'package:flutter_e_commerce/ui/product_details.dart';
import 'package:flutter_e_commerce/ui/search_screen.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carousalImage = [];
  List _products = [];
  var _dotPosition = 0;

  var _firestoreInstance = FirebaseFirestore.instance;
  fetchCarousal()async{
    
    QuerySnapshot qn = await _firestoreInstance.collection('carousel-slider').get();
    setState(() {
      for(int i=0; i<qn.docs.length; i++)
      {
        _carousalImage.add(qn.docs[i]['path']);

      }
    });

    return qn.docs;
  }
  
  fetchProducts()async{
    QuerySnapshot qn = await _firestoreInstance.collection('products').get();
   setState(() {
     for(int i=0; i<qn.docs.length; i++)
     {
       _products.add(
           {
             "product-name":qn.docs[i]['product-name'],
             "product-price": qn.docs[i]['product-price'],
             "product-description": qn.docs[i]['product-description'],
             "product-image": qn.docs[i]['product-image'],
           }
       );
     }
   });
   return qn.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCarousal();
    fetchProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),)),
                     readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.pink,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(
                            color: Colors.blue // textfield a click korle ai color ashbe
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                                color: Colors.purple // textfield a click na korle ai color default ashbe
                            )
                        ),
                        hintText: "Search products here",
                        hintStyle: TextStyle(fontSize: 15)
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  color: AppColors.deep_orange,
                  child: Center(child: Icon(Icons.search,color: Colors.white,),),

                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          AspectRatio(aspectRatio: 16/9,
          child: CarouselSlider(items: _carousalImage.map((item) => Padding(
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
          DotsIndicator(dotsCount: _carousalImage.length==0?1:_carousalImage.length,
          position: _dotPosition,
            decorator: DotsDecorator(
              activeColor: AppColors.deep_orange,
              color: Colors.grey,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Top Products',style: TextStyle(color: Colors.red),),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllProductShow(products: _products,),));
                }, child: Text('View all>>',))
              ],
            ),
          ),
          SizedBox(height: 15,),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: _products.length,
                itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: _products[index]),));
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      AspectRatio(aspectRatio: 2,child: Image.network(_products[index]['product-image'][0],fit: BoxFit.cover,)),
                      SizedBox(height: 30,),
                      Text('${_products[index]['product-name']}'),
                      Text('\$${_products[index]['product-price'].toString()}'),
                    ],
                  ),
                ),
              );
            },),
          )
      
      
        ],
      ),
    );
  }
}

