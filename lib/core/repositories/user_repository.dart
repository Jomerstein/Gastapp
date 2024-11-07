import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gastapp/core/models/usuario.dart';


class UserRepository{
  final firebaseFirestore = FirebaseFirestore.instance;


  Future<void> addUser(UserCredential user, String username)async {

    await firebaseFirestore.collection("Users")
    .doc(user.user!.email).set({
      'email': user.user!.email,
      'username': username,
    });

  }

  Future<Usuario?> getUser()async{
  User? user =   FirebaseAuth.instance.currentUser;
  final snapshot;
    if(user != null){
    snapshot = await firebaseFirestore.collection("Users").where("email", isEqualTo: user.email).get();
      if(snapshot.docs.isNotEmpty){
        final userData = snapshot.docs.first.data();
        return Usuario.fromMap(userData);

      }else{
        return null;
      }
    }
    
    return null;
  }
}