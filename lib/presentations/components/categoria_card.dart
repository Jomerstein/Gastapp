import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/presentations/providers/gastos_ingresos_provider.dart';

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
                        ref.read(borrarCategoriaProvider(titulo));
                      },
                    ),
                  ),
                );
  }
}