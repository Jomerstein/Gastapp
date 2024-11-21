import 'package:flutter/material.dart';
import 'package:gastapp/presentations/components/home_button.dart';
import 'package:gastapp/presentations/components/navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        
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
                      Shadow(
                        color: Colors.grey,
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                      )
                    ])),
            Spacer(),
             HomeButton(
                color: Color.fromARGB(204, 255, 59, 48),
                textContent: 'Gastos / Ingresos',
                route: 'gastosingresos'),
         
             Spacer(),
             HomeButton(
                color: Color.fromARGB(204, 48, 131, 255),
                textContent: 'Listado',
                route: 'consultas'),
                 Spacer(),
             HomeButton(color: Colors.green, textContent: "Balance", route: "balance"),
             SizedBox(height: 30,)
          ],
        ),
      ),
      bottomNavigationBar:  Navbar(),
    );
  }
}
