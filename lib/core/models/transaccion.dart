import 'package:cloud_firestore/cloud_firestore.dart';

class  Transaccion {
final String id;
final String descripcion;
final String tipoDeMoneda;
final double monto;
final String categoria;


  Transaccion({
    this.id = "1",
  
    required this.descripcion,
    required this.tipoDeMoneda,
    required this.monto,
    required this.categoria
    
  });
   Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'tipoDeMoneda' : tipoDeMoneda,
      'monto': monto,
      'categoria': categoria,
     
    };
   }
   factory Transaccion.fromMap(Map<String, dynamic> data) {
    return Transaccion(
      id: data['id'] ?? '',
      descripcion: data['descripcion'] ?? '', // Si estás almacenando el ID en el documento
      tipoDeMoneda: data['tipoDeMoneda'] ?? '',
      monto: data['monto'] ?? '',
      categoria: data['categoria'] ?? '',
  
    );
  }

}