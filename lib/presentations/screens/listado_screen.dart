import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/transaccion.dart';

import 'package:gastapp/presentations/providers/consultas_providers.dart';
class ListaIngresosWidget extends ConsumerStatefulWidget {
  final String descripcion;

  const ListaIngresosWidget({super.key, required this.descripcion});

  @override
  _ListaIngresosWidgetState createState() => _ListaIngresosWidgetState();
}

class _ListaIngresosWidgetState extends ConsumerState<ListaIngresosWidget> {
  @override
  void initState() {
    super.initState();
    // Refresca el provider al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIngresos();
    });
    
  }

   Future<void> _refreshIngresos() async {
    ref.read(loadingProvider.notifier).state = true; // Inicia el estado de carga
    await ref.refresh(getIngresosFutureProvider(widget.descripcion).future);
    ref.read(loadingProvider.notifier).state = false; // Termina el estado de carga
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider.notifier).state;
    final ingresosAsyncValue = ref.watch(getIngresosFutureProvider(widget.descripcion));
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: isLoading? const Center(child: CircularProgressIndicator(),) :
       ingresosAsyncValue.when(
        data: (ingresos) {
          return ListView.builder(
            itemCount: ingresos.length,
            itemBuilder: (context, index) {
              final ingreso = ingresos[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    ingreso.descripcion,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Monto: ${ingreso.monto.toStringAsFixed(2)} ${ingreso.tipoDeMoneda}'),
                      Text('Categoría: ${ingreso.categoria}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _eliminarIngreso(ref, ingreso);
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
    Future<void> _eliminarIngreso(WidgetRef ref, Transaccion transaccion) async {
    ref.read(loadingProvider.notifier).state = true; // Inicia el estado de carga
    await ref.read(borrarTransaccionFutureProvider(transaccion).future);
    await _refreshIngresos(); // Refresca la lista de ingresos
    print("Transacción borrada");
  }
}


