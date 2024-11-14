import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/presentations/components/mensaje_pop.dart';
import 'package:gastapp/presentations/components/send_button.dart';
import 'package:gastapp/presentations/components/text_field_auth.dart';
import 'package:gastapp/presentations/providers/login_register_provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const  LoginScreen({super.key});




 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
     void login()async {
     showDialog(context: context, builder: (context)=> const Center(child: CircularProgressIndicator(),));

     try{
      ref.read(loginProvider(LoginParams(email: emailController.text, password: passwordController.text)));
      if(context.mounted){
        context.pop();
          context.pushNamed("auth");
      } 
     } 
     on FirebaseAuthException catch(e){
        context.pop();
        mensajePop(e.message, context, false);
       
     } on PlatformException catch (e) {

      context.pop();
      mensajePop("Error de conexión o plataforma: ${e.message}", context, false);


     }
  }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(height: 25),
              
                  const Text("GastApp", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),),
                  const SizedBox(height: 20),
                  TextFieldAuth(hintText: "Usuario", isPass: false, textEditingController: emailController),
                  const SizedBox(height: 20),
                  TextFieldAuth(hintText: "Contraseña", isPass: true, textEditingController: passwordController),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Olvidaste tu contraseña?")
                  ],),
                  const SizedBox(height: 40,),
                  SendButton(text: "Iniciar sesión", color: Colors.grey, funcion: login,),
                  const SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No tenes cuenta? "),
                      GestureDetector(
                        onTap: () => {
                          context.pushNamed("register")
                        },
                        child: const Text("Registrate", style: TextStyle(fontWeight: FontWeight.bold),
                        )
                        )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}