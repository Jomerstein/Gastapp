
import 'package:gastapp/core/models/transaccion.dart';

class Ingreso extends Transaccion {
  Ingreso({required super.descripcion, required super.tipoDeMoneda, required super.monto, required super.categoria, super.id,});
  
    factory Ingreso.fromMap(Map<String, dynamic> data) {
    return Ingreso(
      id: data['id'], // El ID puede venir del mapa
      descripcion: data['descripcion'] ?? '', 
      tipoDeMoneda: data['tipoDeMoneda'] ?? '',
      monto: (data['monto'] ?? 0).toDouble(), // Asegura que sea double
      categoria: data['categoria'] ?? '',
    );
  }

  
}