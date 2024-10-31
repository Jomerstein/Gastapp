import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gastapp/core/models/transaccion.dart';

class Gasto extends Transaccion {
  Gasto({required super.descripcion, required super.tipoDeMoneda, required super.monto, required super.categoria, required super.id});

   factory Gasto.fromMap(Map<String, dynamic> data) {
    return Gasto(
      id: data['id'] ?? '',
      descripcion: data['descripcion'] ?? '', // Si estás almacenando el ID en el documento
      tipoDeMoneda: data['tipoDeMoneda'] ?? '',
      monto: data['monto'] ?? '',
      categoria: data['categoria'] ?? '',

    );
  }
}