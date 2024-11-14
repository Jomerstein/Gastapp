import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/presentations/components/mensaje_pop.dart';
import 'package:gastapp/presentations/components/send_button.dart';
import 'package:gastapp/presentations/components/text_field_auth.dart';
import 'package:gastapp/presentations/providers/login_register_provider.dart';
import 'package:go_router/go_router.dart';


class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});



  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

    void register() async{
    showDialog(context: context, builder: (context)=> const Center(child: CircularProgressIndicator(),));

    if(passwordConfirmController.text != passwordController.text){
      Navigator.pop(context);
       mensajePop("Las contraseñas deben coincidir", context, false);
       
    }else{

    
    try{
      ref.read(registerProvider(RegisterParams(usernameController.text, email: emailController.text, password: passwordConfirmController.text)));
      Navigator.pop(context);
      context.pushNamed("auth");
    } on FirebaseAuthException catch(e){
         GoRouter.of(context).pop();
        mensajePop(e.toString(), context, false);
    } on PlatformException catch (e){
       GoRouter.of(context).pop();
      mensajePop(e.toString(), context, false);
    }catch(e){
     // context.pop();
      mensajePop(e.toString(), context, false);
    }
    }
  
  }
    
    
    return Scaffold(
      body: SingleChildScrollView(
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
                TextFieldAuth(hintText: "Nombre de usuario", isPass: false, textEditingController: usernameController),
                const SizedBox(height: 20),
                TextFieldAuth(hintText: "Email", isPass: false, textEditingController: emailController),
                const SizedBox(height: 20),
                TextFieldAuth(hintText: "Ingrese una contraseña", isPass: true, textEditingController: passwordController),
                const SizedBox(height: 20),
                TextFieldAuth(hintText: "Repita su contraseña", isPass: true, textEditingController: passwordConfirmController),
                const SizedBox(height: 4),
                const SizedBox(height: 40,),
                SendButton(text: "Registrate", color: Colors.grey, funcion: register,),
                const SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ya tenes cuenta? "),
                    GestureDetector(
                      onTap: () => {
                        context.pushNamed("login")
                      },
                      child: const Text("Ingresá", style: TextStyle(fontWeight: FontWeight.bold),
                      )
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}