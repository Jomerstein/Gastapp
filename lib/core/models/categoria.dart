class Categoria {
  String id;
  String nombreCategoria;

  Categoria({
    required this.id,
    required this.nombreCategoria
  });
  
   Map<String, dynamic> toMap() {
    return {
      'NombreCategoria': nombreCategoria
   };
   }
   factory Categoria.fromMap(Map<String, dynamic> data) {
    return Categoria(
      id: data['id'] ?? '',
      nombreCategoria: data['NombreCategoria'] ?? '',
    );
  }

}

