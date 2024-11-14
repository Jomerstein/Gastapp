import 'package:uuid/uuid.dart';

class Categoria {
  String id;
  String nombreCategoria;
  String userId;

  Categoria({
    String? id,
    required this.nombreCategoria,
    required this.userId,
  }): id = id ?? const Uuid().v4();
  
   Map<String, dynamic> toMap() {
    return {
      'NombreCategoria': nombreCategoria,
      'userId': userId,
      'id': id,
   };
   }
   factory Categoria.fromMap(Map<String, dynamic> data) {
    return Categoria(
      id: data['id'] ?? '',
      nombreCategoria: data['NombreCategoria'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

}

