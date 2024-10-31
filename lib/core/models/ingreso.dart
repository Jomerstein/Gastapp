import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gastapp/core/models/transaccion.dart';

class Ingreso extends Transaccion {
  Ingreso({required super.descripcion, required super.tipoDeMoneda, required super.monto, required super.categoria, required super.id,});
  
     factory Ingreso.fromMap(Map<String, dynamic> data) {
    return Ingreso(
      id: data['id'] ?? '',
      descripcion: data['descripcion'] ?? '', // Si estás almacenando el ID en el documento
      tipoDeMoneda: data['tipoDeMoneda'] ?? '',
      monto: data['monto'] ?? '',
      categoria: data['categoria'] ?? '', 
 
    );
  }
}