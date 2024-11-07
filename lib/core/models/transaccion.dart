

import 'package:uuid/uuid.dart';

class Transaccion {
  final String id; // Cambié el tipo a String no nulo
  final String descripcion;
  final String tipoDeMoneda;
  final double monto;
  final String categoria;
  final String userId;

  Transaccion({
    String? id, // ID opcional en el constructor
    required this.descripcion,
    required this.tipoDeMoneda,
    required this.monto,
    required this.categoria,
    required this.userId,
  }) : id = id ?? const Uuid().v4();
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descripcion': descripcion,
      'tipoDeMoneda': tipoDeMoneda,
      'monto': monto,
      'categoria': categoria,
      'userId': userId,
    };
  }

  factory Transaccion.fromMap(Map<String, dynamic> data) {
    return Transaccion(
      id: data['id'] ?? const Uuid().v4(), // Asegura que siempre haya un ID
      descripcion: data['descripcion'] ?? '',
      tipoDeMoneda: data['tipoDeMoneda'] ?? '',
      monto: (data['monto'] ?? 0).toDouble(), // Asegura que sea double
      categoria: data['categoria'] ?? '',
      userId: data['userId'] ?? '',
    );
  }
}