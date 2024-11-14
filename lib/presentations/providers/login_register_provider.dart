  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/repositories/user_repository.dart';

    final loginProvider = StateProvider.family<void, LoginParams>((ref,params) async {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: params.email, password: params.password);
    });
    
    final registerProvider = StateProvider.family<void, RegisterParams>((ref, params) async {
      UserRepository repository = UserRepository();
      try{
        UserCredential? user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: params.email, password: params.password);
      repository.addUser(user, params.username);
      }catch(e){
        throw Error();
      }
 
    });
    
class LoginParams{

  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

}

class RegisterParams{
  final String email;
  final String password;
  final String username;

  RegisterParams(this.username, {required this.email, required this.password});
}
  
