import 'package:flutter/material.dart';
import 'package:gastapp/presentations/components/homeButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   

    return const Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
            SizedBox(height: 50),
            Text('GastAPP', 
            style: TextStyle(
            fontSize: 60, 
            fontFamily: 'Reem Kufi Ink', 
            color: Colors.black,
            shadows: [
              Shadow(color: Colors.grey, // Color de la sombra
              offset: Offset(3.0, 3.0), // Desplazamiento de la sombra
              blurRadius: 5.0,) // Difuminado de la sombra)
            ]
            
            
            )
            ),
            SizedBox(height: 50),
            HomeButton(color:Color.fromARGB(204, 52, 199, 89),textContent:  'Ingresos', route:  'hola'),
            SizedBox(height: 50),
            HomeButton(color:Color.fromARGB(204, 255, 59, 48) ,textContent:  'Gastos', route:  'hola'),
            SizedBox(height: 50),
            HomeButton(color:Color.fromARGB(204, 48, 131, 255),textContent:  'Consultas', route:  'hola'),
          
          ],
        ),
      )
    );
  }
}

