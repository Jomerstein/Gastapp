import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final Color color;
  final String textContent;
  final String route;
  
   const HomeButton({
   
    required this.color, 
    required this.textContent,
    required  this.route,
     super.key}
    );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 60,
      height: 80,
      child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color
        
      ),
      onPressed: ()=>{'TENGO QUE HACER ESTO', print('ellcoo')}, //HACER EL ROUTER
      child:  Text(textContent, style: const TextStyle(color: Colors.black, fontSize: 30)
      )
      ),
    );
  }
}