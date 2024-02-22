import 'package:flutter/material.dart';

import '../const/AppColors.dart';

Widget CustomButton(String btnText, onPressedFunction,BuildContext context)
{
  return Container(
    width: MediaQuery.of(context).size.width/0.8,
    decoration: BoxDecoration(

    ),
    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.deep_orange,
        shape: RoundedRectangleBorder()),onPressed: onPressedFunction,child: Text(btnText,style: TextStyle(color: Colors.white,fontSize: 20),),),
  );
}