import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/presentations/providers/consultas_providers.dart';

class ListaIngresosWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lee el estado del FutureProvider ingresosFiltradosProvider
    final ingresosAsyncValue = ref.watch(getIngresosFutureProvider);

    return ingresosAsyncValue.when(
      data: (ingresos) {
        // Devuelve una lista de widgets que muestran los ingresos
        return ListView.builder(
          itemCount: ingresos.length,
          itemBuilder: (context, index) {
            final ingreso = ingresos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(ingreso.descripcion, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Monto: ${ingreso.monto.toStringAsFixed(2)} ${ingreso.tipoDeMoneda}'),
                    Text('Categoría: ${ingreso.categoria}'),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}