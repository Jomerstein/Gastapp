import 'package:flutter/widgets.dart';

class SendButton extends StatelessWidget {
  final String text;
  final void Function()? funcion;
  final Color color;
  const SendButton({super.key, required this.text, this.funcion, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcion,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Text(text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),)
          )
          ),
      
    );
  }
}