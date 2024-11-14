import 'package:gastapp/core/auth/auth.dart';
import 'package:gastapp/presentations/screens/balance_screen.dart';
import 'package:gastapp/presentations/screens/consultas_screen.dart';
import 'package:gastapp/presentations/screens/gastos_ingresos_screen.dart';
import 'package:gastapp/presentations/screens/home_screen.dart';

import 'package:gastapp/presentations/screens/listado_screen.dart';
import 'package:gastapp/presentations/screens/login_screen.dart';
import 'package:gastapp/presentations/screens/profile_screen.dart';
import 'package:gastapp/presentations/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state)=>  const AuthScreen()),
    GoRoute(name:"auth",path: '/auth', builder: (context, state)=>  const AuthScreen()),
    GoRoute(name:"profile",path: '/profile', builder: (context, state)=>   const ProfileScreen()),
    GoRoute(name: "home", path: '/home', builder: (context, state)=>  const HomeScreen()),
    GoRoute(name:'gastosingresos',path: '/gastosingresos', builder: (context, state) =>  GastosIngresosScreen()),
    GoRoute(name:'consultas',path: '/consultas', builder: (context, state) => const  ConsultasScreen()),
    GoRoute(name: 'listado',path: '/listado', builder: (context, state) =>  const ListadoScreen()), 
    GoRoute(path: "/register", name: "register", builder:(context, state) => const RegisterScreen(),),
    GoRoute(path: "/login", name: "login", builder:(context, state) =>  const LoginScreen(),),
    GoRoute(path: "/balance", name: "balance", builder:(context, state) => const BalanceScreen(),),
   
    
  ]
);