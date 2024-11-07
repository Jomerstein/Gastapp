import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/router/app_router.dart';
import 'package:gastapp/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'gastapp-847f9',
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      
      routerConfig: appRouter,
      theme: ThemeData(colorSchemeSeed:  const Color.fromARGB(255, 242, 242, 247))
      
    );
  }
}
