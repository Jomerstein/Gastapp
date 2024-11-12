
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void mensajePop(String? mensaje, BuildContext context, bool isSucceed){
  showDialog(context: context, builder: (context)=> AlertDialog(
    title: Text(mensaje ?? '',
    style: TextStyle(color: isSucceed? Colors.green : Colors.red ),),
    actions: [
           TextButton(
            onPressed: () {
              context.pop(); // Cierra el diálogo
            },
            child: const Text('Continuar')),
      ],
  )
  );
}