import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/transaccion.dart';
import 'package:gastapp/core/repositories/repository.dart';
import 'package:gastapp/presentations/components/navbar.dart';
import 'package:gastapp/presentations/providers/consultas_providers.dart';
import 'package:gastapp/presentations/providers/firebase.provider.dart';
import 'package:go_router/go_router.dart';

class ListadoScreen extends ConsumerWidget {
  const ListadoScreen({super.key});

 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    Future<void> eliminarTransaccion(WidgetRef ref, Transaccion transaccion) async {
    await ref.read(borrarTransaccionFutureProvider(transaccion).future);
     }
     //lo debería hacer un servicio? si lo debo pasar a riverpod
    Stream<List<Transaccion>>? getTransacciones(){ 
    final repository = IngresoRepository(ref.watch(firebaseFirestoreProvider));
    final tipo = ref.watch(tipoSeleccionadoProvider.notifier).state;
    final categoria = ref.watch(categoriaSeleccionadaConsultaProvider.notifier).state;
    final descripcion = ref.watch(descripcionSeleccionadaProvider.notifier).state;
    final anio = ref.watch(anioSeleccionadoProvider.notifier).state;
    if(tipo == "Gasto"){
      return repository.getGastos(descripcion, categoria, anio);
    }else{
      return repository.getIngresos(descripcion, categoria, anio);
    }

  }  
  return  Scaffold(
    appBar: AppBar(
        title: const Text(
          'Listado',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(stream: getTransacciones(), builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                  child: CircularProgressIndicator()
              );
          }
          final transacciones = snapshot.data;

          if(transacciones!.isEmpty || snapshot.data == null){
             WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No se encontraron transacciones")),
              );
            context.go("/consultas");
            });
            return const SizedBox.shrink();
          }
          return ListView.builder(
              itemCount: transacciones.length,
              itemBuilder: (context, index){
              final transaccion = transacciones[index];
              return  Card(
                  
                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      transaccion.descripcion,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Monto: ${transaccion.monto.toStringAsFixed(2)} ${transaccion.tipoDeMoneda}'),
                        Text('Categoría: ${transaccion.categoria}'),
                        Text('Fecha: ${transaccion.fecha}' )
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        eliminarTransaccion(ref, transaccion);
                      },
                    ),
                  ),
                );
              } );
              
      }),
      bottomNavigationBar: const Navbar(),
    );
  }
}