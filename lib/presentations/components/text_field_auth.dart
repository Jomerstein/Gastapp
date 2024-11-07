import 'package:flutter/material.dart';


class TextFieldAuth extends StatelessWidget {
  final String hintText;
  final bool isPass;
  final TextEditingController textEditingController;
  const TextFieldAuth({super.key, required this.hintText, required this.isPass, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey)
      ),
      obscureText: isPass,
    );
  }
}