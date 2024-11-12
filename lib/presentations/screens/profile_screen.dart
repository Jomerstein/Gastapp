import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/core/models/usuario.dart';
import 'package:gastapp/core/repositories/user_repository.dart';
import 'package:gastapp/core/router/app_router.dart';
import 'package:gastapp/presentations/components/categoria_card.dart';
import 'package:gastapp/presentations/components/navbar.dart';
import 'package:gastapp/presentations/components/send_button.dart';
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
  
  body: Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0), 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          const Text(
            "Nombre de usuario",
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold, 
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 16), // Espacio entre el título y el FutureBuilder
          FutureBuilder<Usuario?>(
            future: usersRepository.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                );
              }
              if (snapshot.hasData) {
                final user = snapshot.data;
                return Column(
                  children: [
                    Text(
                      user!.email,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8), // Espacio entre los dos textos
                    Text(
                      user.username,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              } else {
                return const Text(
                  "Usuario no encontrado",
                  style: TextStyle(color: Colors.grey),
                );
              }
            },
          ),
          SizedBox(height: 30,),
          const Text("Categorias", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),),
          SizedBox(height: 30,),
          
            StreamBuilder<List<Categoria>>(stream: categorias, builder: (context, snapshot){
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
           const  Spacer(),
          SendButton(text: "Cerrar Sesión", color: Colors.grey, funcion: cerrarSesion,)
        ],
      ),
    ),
  ),
  bottomNavigationBar: const Navbar(),
);
  }
}
