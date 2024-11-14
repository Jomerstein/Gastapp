import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/core/models/gasto.dart';
import 'package:gastapp/core/models/transaccion.dart';

import '../models/ingreso.dart';

class IngresoRepository {
  final FirebaseFirestore _firestore;

  IngresoRepository(this._firestore);
  Stream<List<Ingreso>>? getIngresos(String? descripcion, String? categoria, DateTime? fecha)  {
  try {

    Query<Map<String, dynamic>> query = _firestore.collection("Ingresos");

    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      query = query.where('userId', isEqualTo: user.email);
    }

    if (categoria != null) {
      query = query.where('categoria', isEqualTo: categoria);

    }
    if (descripcion != null) {
      query = query.where('descripcion', isEqualTo: descripcion);
    }
    if(fecha != null){
      query = query.where('fecha', isEqualTo: fecha);
    }

    final snapshot =  query.snapshots();


    final ingreso = snapshot.map((snapshot) {
      return snapshot.docs.map((doc) {
        return Ingreso.fromSnapshot(doc.data()); 
      }).toList();
    });
    return ingreso;
  } catch (e) {

     return null;
  }
}

  Stream<List<Gasto>>? getGastos(String? descripcion, String? categoria, DateTime? fecha)  {
  try {

    Query<Map<String, dynamic>> query = _firestore.collection("Gastos");
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      query = query.where('userId', isEqualTo: user.email);
    }
    if (categoria != null) {
      query = query.where('categoria', isEqualTo: categoria);
    }
    if (descripcion != null && descripcion.isNotEmpty) {
      query = query.where('descripcion', isEqualTo: descripcion);
     
    }
    if(fecha != null){
      query = query.where('fecha', isEqualTo: fecha);
    }

    final snapshot =  query.snapshots();


    final gastos = snapshot.map((snapshot) {
      return snapshot.docs.map((doc) {
        return Gasto.fromSnapshot(doc.data()); 
      }).toList();
    });
    return gastos;
  } catch (e) {

     return null;
  }
}

  Future<void> deleteTransaccion(Transaccion transaccion) async{
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if(transaccion.userId == FirebaseAuth.instance.currentUser!.email){
        if(transaccion is Ingreso){
        querySnapshot = await FirebaseFirestore.instance
        .collection('Ingresos')
        .where('id', isEqualTo: transaccion.id)
        .get();
      }else{
          querySnapshot = await FirebaseFirestore.instance
        .collection('Gastos')
        .where('id', isEqualTo: transaccion.id) // Cambiar esto a id
        .get();
        
      }
   

    // Borrar cada documento encontrado
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
      
    }
      }
      
  
  } catch (e) {
    
  }
}
  
  

  Future<void> addTransaccion(Transaccion transaccion) async {
    if(transaccion is Ingreso){
     await _firestore.collection('Ingresos').add(transaccion.toMap());
    }else{
      await _firestore.collection('Gastos').add(transaccion.toMap());
    }
  }
  
  Future<void> addCategoria (Categoria categoria) async {
    await _firestore.collection('Categorias').add(categoria.toMap());
  }
  
  Stream<List<Categoria>> getCategorias() {
  return _firestore.collection('Categorias').
    where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.email).
    snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Categoria.fromMap(doc.data())).toList());
}
  Future<void> deleteCategoria(String nombreCategoria) async{
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot;

        querySnapshot = await FirebaseFirestore.instance
        .collection('Categorias')
        .where('NombreCategoria', isEqualTo: nombreCategoria)
        .get();
        
         for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
    }
        deleteTransaccionesPorCategoria(nombreCategoria);
      
      }catch(e){
        
      }
    
  }

  Future<void> deleteTransaccionesPorCategoria(String nombreCategoria)async {
         QuerySnapshot<Map<String, dynamic>> querySnapshot;
        try{
          
         querySnapshot = await FirebaseFirestore.instance
              .collection('Ingresos')
        .where('categoria', isEqualTo: nombreCategoria)
        .get();
        
        for(var doc in querySnapshot.docs){
          if(FirebaseAuth.instance.currentUser!.email == doc['userId']){
              await doc.reference.delete();
          }
          
        }
        querySnapshot = await FirebaseFirestore.instance.collection("Gastos")
         .where('categoria', isEqualTo: nombreCategoria)
         .get();
        for(var doc in querySnapshot.docs){
         if(FirebaseAuth.instance.currentUser!.email == doc['userId']){
              await doc.reference.delete();
          }
        }
        }catch(e){

        }
  }
       
  
}

