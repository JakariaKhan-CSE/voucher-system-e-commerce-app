import 'package:flutter/material.dart';

import '../const/AppColors.dart';

Widget CustomButton(String btnText, onPressedFunction,BuildContext context)
{
  return Container(
    width: MediaQuery.of(context).size.width/0.8,
    decoration: const BoxDecoration(

    ),
    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.deep_orange,
        shape: const RoundedRectangleBorder()),onPressed: onPressedFunction,child: Text(btnText,style: const TextStyle(color: Colors.white,fontSize: 20),),),
  );
}