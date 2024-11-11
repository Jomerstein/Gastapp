
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void mensajePop(String? mensaje, BuildContext context, bool isSucceed){
  showDialog(context: context, builder: (context)=> AlertDialog(
    title: Text(mensaje ?? '',
    style: TextStyle(color: isSucceed? Colors.green : Colors.red ),),

  ));
}