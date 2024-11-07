import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gastapp/presentations/screens/home_screen.dart';
import 'package:gastapp/presentations/screens/login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (constext, snapshot){
        if(snapshot.hasData){
         return const HomeScreen();
        }else{
          return LoginScreen();
        }
     
      }
      ),
    );
  }
}