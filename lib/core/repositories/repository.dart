import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/core/models/transaccion.dart';
import '../models/ingreso.dart';

class IngresoRepository {
  final FirebaseFirestore _firestore;

  IngresoRepository(this._firestore);
 Future<List<Ingreso>> getIngresos(String descripcion) async {
    final snapshot = await _firestore
        .collection("Ingresos")
        .where('descripcion', isEqualTo: descripcion)
        .get();

    // Asegúrate de mapear los documentos a objetos `Ingreso`
    final ingresos = snapshot.docs.map((doc) {
      return Ingreso.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    return ingresos;
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
  return _firestore.collection('Categorias').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Categoria.fromMap(doc.data())).toList());
}




}

