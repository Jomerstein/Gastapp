class Categoria {
  String id;
  String nombreCategoria;
  String userId;

  Categoria({
    required this.id,
    required this.nombreCategoria,
    required this.userId,
  });
  
   Map<String, dynamic> toMap() {
    return {
      'NombreCategoria': nombreCategoria,
      'userId': userId
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

