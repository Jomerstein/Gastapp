class Usuario {
  final String email; // Cambié el tipo a String no nulo
  final String username;

  Usuario({required this.email, required this.username});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      
    };
  }

    factory Usuario.fromMap(Map<String, dynamic> data) {
    return Usuario(
      email: data['email'] ?? "", // Asegura que siempre haya un ID
      username: data['username'] ?? '',

    );}
}