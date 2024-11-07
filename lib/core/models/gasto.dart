
import 'package:gastapp/core/models/transaccion.dart';

class Gasto extends Transaccion {
  Gasto({required super.descripcion, required super.tipoDeMoneda, required super.monto, required super.categoria, super.id, required super.userId});

   factory Gasto.fromMap(Map<String, dynamic> data) {
    return Gasto(
      id: data['id'],
      descripcion: data['descripcion'] ?? '', // Si estás almacenando el ID en el documento
      tipoDeMoneda: data['tipoDeMoneda'] ?? '',
      monto: data['monto'] ?? '',
      categoria: data['categoria'] ?? '',
      userId: data['userId'] ?? '',


    );
  }
    factory Gasto.fromSnapshot(Map<String, dynamic> json) {
    return Gasto(

      id: json["id"] as String?,
      descripcion: json['descripcion'] as String, // Si estás almacenando el ID en el documento
      monto: (json['monto'] as num).toDouble(), // Convertimos a double si es necesario
      tipoDeMoneda: json['tipoDeMoneda'] as String,
      categoria: json['categoria'] as String,
      userId: json['userId'] as String,
    );
  }

  
}