

import 'package:uuid/uuid.dart';

class Transaccion {
  final String id; 
  final String descripcion;
  final String tipoDeMoneda;
  final double monto;
  final String categoria;
  final String userId;
  final DateTime fecha;

  Transaccion({
    String? id, 
    required this.descripcion,
    required this.tipoDeMoneda,
    required this.monto,
    required this.categoria,
    required this.userId,
    required this.fecha,
  }) : id = id ?? const Uuid().v4();
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descripcion': descripcion,
      'tipoDeMoneda': tipoDeMoneda,
      'monto': monto,
      'categoria': categoria,
      'userId': userId,
      'fecha': fecha,
    };
  }

  factory Transaccion.fromMap(Map<String, dynamic> data) {
    return Transaccion(
      id: data['id'] ?? const Uuid().v4(), 
      descripcion: data['descripcion'] ?? '',
      tipoDeMoneda: data['tipoDeMoneda'] ?? '',
      monto: (data['monto'] ?? 0).toDouble(), // Asegura que sea double
      categoria: data['categoria'] ?? '',
      userId: data['userId'] ?? '',
      fecha: data['fecha'] ?? '',
    );
  }
}