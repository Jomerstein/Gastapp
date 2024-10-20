import 'package:flutter/material.dart';
import 'package:gastapp/presentations/components/home_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   

    return  Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
            const SizedBox(height: 50),
            const Text('GastAPP', 
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
            SizedBox(
              height: MediaQuery.of(context).size.height - 700),
            const HomeButton(color:Color.fromARGB(204, 255, 59, 48) ,textContent:  'Gastos / Ingresos', route:  'gastosingresos'),
            const SizedBox(height: 50),
            const HomeButton(color:Color.fromARGB(204, 48, 131, 255),textContent:  'Consultas', route:  'gastosingresos'), //cambiar esto
          
          ],
        ),
      )
    );
  }
}

