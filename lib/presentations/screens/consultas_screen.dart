import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/presentations/components/navbar.dart';
import 'package:gastapp/presentations/providers/consultas_providers.dart';
import 'package:gastapp/presentations/providers/gastos_ingresos_provider.dart';
import 'package:go_router/go_router.dart';

class ConsultasScreen extends ConsumerWidget {
  const ConsultasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController descripcionController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final tipoSeleccionado = ref.watch(tipoSeleccionadoProvider);
    final categoriaSeleccionada =
        ref.watch(categoriaSeleccionadaConsultaProvider);
    final categorias = ref.watch(getCategoriasProvider);

    InputDecoration inputDecoration(bool enabled) {
      return const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
        appBar: AppBar(
        title: const Text(
          'Listado',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('TIPO'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                items: ['Gasto', 'Ingreso']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  ref.watch(tipoSeleccionadoProvider.notifier).state = value;
                  ref.watch(categoriaSeleccionadaProvider.notifier).state =
                      null;
                  ref.watch(anioSeleccionadoProvider.notifier).state = null;
                },
                decoration: inputDecoration(true),
                value: tipoSeleccionado,
              ),
              const SizedBox(height: 16),
              const Text('CATEGORIA'),
              const SizedBox(height: 8),
              categorias.when(
                data: (categorias) {
                  return DropdownButtonFormField<String>(
                    items: categorias.map((Categoria categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria.nombreCategoria,
                        child: Text(categoria.nombreCategoria),
                      );
                    }).toList(),
                    onChanged: tipoSeleccionado != null
                        ? (value) {
                            ref
                                .watch(categoriaSeleccionadaConsultaProvider
                                    .notifier)
                                .state = value;
                            ref.watch(anioSeleccionadoProvider.notifier).state =
                                null;
                          }
                        : null,
                    decoration: inputDecoration(tipoSeleccionado != null),
                    value: categoriaSeleccionada,
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
              const SizedBox(height: 16),
              const Text('FECHA'),
              const SizedBox(height: 8),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Seleccione una fecha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2050),
                  );

                  if (selectedDate != null) {
                    ref.read(anioSeleccionadoProvider.notifier).state =
                        selectedDate;
                    dateController.text =
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                  }
                },
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              const Text('DESCRIPCION'),
              const SizedBox(height: 8),
              TextField(
                controller: descripcionController,
                decoration: inputDecoration(true),
                onChanged: (value) {
                  ref.read(descripcionSeleccionadaProvider.notifier).state =
                      value;
                },
              ),
              const SizedBox(height: 16),
             
              Row(
                children: [
                   Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      'listado',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                  ),
                  child: const Text(
                    'Buscar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
                  ElevatedButton(
                    onPressed: () => {
                      ref.read(tipoSeleccionadoProvider.notifier).state = null,
                      ref
                          .read(categoriaSeleccionadaConsultaProvider.notifier)
                          .state = null,
                      ref.read(descripcionSeleccionadaProvider.notifier).state =
                          null,
                      ref.read(anioSeleccionadoProvider.notifier).state = null,
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 50),
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
              
                 
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
