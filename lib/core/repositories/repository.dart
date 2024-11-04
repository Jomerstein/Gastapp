import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/core/models/gasto.dart';
import 'package:gastapp/core/models/transaccion.dart';
import '../models/ingreso.dart';

class IngresoRepository {
  final FirebaseFirestore _firestore;

  IngresoRepository(this._firestore);
 Future<List<Ingreso>> getIngresos(String? descripcion, String? categoria) async {
  try {
    
    Query<Map<String, dynamic>> query = _firestore.collection("Ingresos");

    if (categoria != null) {
      query = query.where('categoria', isEqualTo: categoria);
      print("Entro categoria");
    }
    if (descripcion != null) {
      query = query.where('descripcion', isEqualTo: descripcion);
      print("Entro descripcion");
    }


    final snapshot = await query.get();

    // Procesa y devuelve los resultados
    final ingresos = snapshot.docs.map((doc) {
      return Ingreso.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    return ingresos;
  } catch (e) {
    print('Error en la consulta: $e');
    return [];
  }
}

  Future<List<Gasto>> getGastos(String? descripcion, String? categoria) async {
  try {

    Query<Map<String, dynamic>> query = _firestore.collection("Gastos");

  
    if (categoria != null) {
      query = query.where('categoria', isEqualTo: categoria);
      print("Entro categoria");
    }
    if (descripcion != null) {
      query = query.where('descripcion', isEqualTo: descripcion);
      print("Entro descripcion");
    }

    final snapshot = await query.get();


    final gastos = snapshot.docs.map((doc) {
      return Gasto.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    return gastos;
  } catch (e) {
    print('Error en la consulta: $e');
    return []; // Retorna una lista vacía si hay un error
  }
}

  Future<void> deleteTransaccion(Transaccion transaccion) async{
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot;
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
        print(transaccion.id);
      }
   

    // Borrar cada documento encontrado
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
    print('Ingreso(s) eliminado(s) correctamente');
  } catch (e) {
    print('Error al eliminar el ingreso: $e');
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
  return _firestore.collection('Categorias').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Categoria.fromMap(doc.data())).toList());
}




}

