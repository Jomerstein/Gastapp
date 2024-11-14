
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gastapp/core/models/transaccion.dart';

class Ingreso extends Transaccion {
  Ingreso({required super.descripcion, required super.tipoDeMoneda, required super.monto, required super.categoria, super.id, required super.userId, required super.fecha,});
  
    factory Ingreso.fromMap(Map<String, dynamic> data) {
    return Ingreso(
      id: data['id'], 
      descripcion: data['descripcion'] ?? '', 
      tipoDeMoneda: data['tipoDeMoneda'] ?? '',
      monto: (data['monto'] ?? 0).toDouble(), 
      categoria: data['categoria'] ?? '',
      userId: data['userId'] ?? '',
      fecha: data['fecha'] ?? ''
    );
  }
      factory Ingreso.fromSnapshot(Map<String, dynamic> json) {
    return Ingreso(

      id: json["id"] as String?,
      descripcion: json['descripcion'] as String, // Si estás almacenando el ID en el documento
      monto: (json['monto'] as num).toDouble(), // Convertimos a double si es necesario
      tipoDeMoneda: json['tipoDeMoneda'] as String,
      categoria: json['categoria'] as String,
      userId: json['userId'] as String,
      fecha: (json['fecha'] as Timestamp).toDate()
    );
  }


  
}