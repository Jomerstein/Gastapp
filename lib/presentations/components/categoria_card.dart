import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/presentations/providers/gastos_ingresos_provider.dart';
import 'package:go_router/go_router.dart';

class CategoriaCard extends ConsumerWidget {
  final String titulo;

  const CategoriaCard({super.key,required this.titulo });

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
         
    return  Card(
                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      titulo,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                       showDialog(context: context, builder: (context)=> AlertDialog(
                   title: Text("Está seguro que desea borrar la categoría $titulo ?"),
                  content: const Text("Se borrarán todas las transacciones que incluyan esta categoría"),
                  actions: [
                              TextButton(onPressed: ()=>{
                ref.read(borrarCategoriaProvider(titulo)),
                context.pop()
              }, child: const Text("Borrar", style: TextStyle(color: Colors.red),)
              ),
              TextButton(onPressed: ()=> context.pop(), child: const Text("Cancelar"))
           
              ],
              
        
          
              icon: const Icon(Icons.delete, color: Colors.red),
              
      ));
                      },
                    ),
                  ),
                );
  }
}