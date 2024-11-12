import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}
  int _selectedIndex = 0;
class _NavbarState extends State<Navbar> {
 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Cambiar de ruta según el índice seleccionado
    switch (_selectedIndex) {
      case 0:
        context.pushNamed('home');
        break;
      case 1:
        context.pushNamed('balance');
        break;
      case 2:
        context.pushNamed('profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      
    );
  }
}