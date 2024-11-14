import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/core/models/usuario.dart';
import 'package:gastapp/presentations/components/categoria_card.dart';
import 'package:gastapp/presentations/components/navbar.dart';
import 'package:gastapp/presentations/providers/firebase.provider.dart';
import 'package:gastapp/presentations/providers/gastos_ingresos_provider.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
   const ProfileScreen({super.key});
  



  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final categorias = ref.watch(getCategoriasProvider.stream);
    final usersRepository = ref.watch(userRepositoryProvider);
     Future.delayed(Duration.zero, () {
     ref.refresh(getCategoriasProvider);  
  });

    void cerrarSesion(){
        FirebaseAuth.instance.signOut();
        context.goNamed("login");
    }
    
return Scaffold(
  body: SafeArea(  
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24), 
            const Text(
              "Perfil",
              style: TextStyle(
                fontSize: 28,  
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<Usuario?>(
              future: usersRepository.getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.red),
                  );
                }
                if (snapshot.hasData) {
                  final user = snapshot.data;
                  return Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email: ${user!.email}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Nombre de usuario: ${user.username}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Text(
                    "Usuario no encontrado",
                    style: TextStyle(color: Colors.grey),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            const Text(
              "Categorías",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder<List<Categoria>>(
              stream: categorias,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay categorías disponibles'));
                }

                final categorias = snapshot.data!;
                return Flexible(
                  child: ListView.builder(
                    itemCount: categorias.length,
                    itemBuilder: (context, index) {
                      return CategoriaCard(titulo: categorias[index].nombreCategoria);
                    },
                  ),
                );
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: cerrarSesion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), 
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), 
                ),
                child: const Text(
                  "Cerrar Sesión",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  bottomNavigationBar: const Navbar(),
);
  }
}
