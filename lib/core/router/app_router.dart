
import 'package:gastapp/presentations/screens/consultas_screen.dart';
import 'package:gastapp/presentations/screens/gastos_ingresos_screen.dart';
import 'package:gastapp/presentations/screens/home_screen.dart';
import 'package:gastapp/presentations/screens/listado_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state)=> const HomeScreen()),
    GoRoute(name:'gastosingresos',path: '/gastosingresos', builder: (context, state) =>  GastosIngresosScreen()),
    GoRoute(name:'consultas',path: '/consultas', builder: (context, state) => const  ConsultasScreen()),
    GoRoute(name:'listado',path: '/listado', builder: (context, state) =>  ListaIngresosWidget())
   
    
  ]
);