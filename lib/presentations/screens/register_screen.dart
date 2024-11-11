import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gastapp/core/repositories/user_repository.dart';
import 'package:gastapp/presentations/components/mensaje_pop.dart';
import 'package:gastapp/presentations/components/send_button.dart';
import 'package:gastapp/presentations/components/text_field_auth.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

    
    UserRepository repository = UserRepository();
    try{
      // hacer validaciones porque por algun motivo no cachea algunos errores
      UserCredential? user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      repository.addUser(user, usernameController.text);
      Navigator.pop(context);
      context.pushNamed("auth");
      
      
    } on FirebaseAuthException catch(e){
         GoRouter.of(context).pop();
        mensajePop(e.toString(), context, false);
        
    } on PlatformException catch (e){
       GoRouter.of(context).pop();
      mensajePop(e.toString(), context, false);
     
    }catch(e){

    }
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }
}