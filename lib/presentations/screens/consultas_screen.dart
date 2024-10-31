import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/presentations/providers/consultas_providers.dart';
import 'package:gastapp/presentations/providers/gastos_ingresos_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';


class ConsultasScreen extends ConsumerWidget {
  const ConsultasScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final TextEditingController descripcionController = TextEditingController();
    final tipoSeleccionado = ref.watch(tipoSeleccionadoProvider);
    final categoriaSeleccionada = ref.watch(categoriaSeleccionadaConsultaProvider);
    final anoSeleccionado = ref.watch(anoSeleccionadoProvider);
    

    final categorias = ref.watch(getCategoriasFutureProvider);
   
   
     InputDecoration _inputDecoration(bool enabled) {
      return InputDecoration(
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey[300],
        border: const OutlineInputBorder(),
      );
    }

       return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Listado', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
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
                ref.read(tipoSeleccionadoProvider.notifier).state = value;
                ref.read(categoriaSeleccionadaProvider.notifier).state = null;
                ref.read(anoSeleccionadoProvider.notifier).state = null;
               
              },
              decoration: _inputDecoration(true),
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
          onChanged: tipoSeleccionado != null ? (value){
          ref.read(categoriaSeleccionadaConsultaProvider.notifier).state = value;
          ref.read(anoSeleccionadoProvider.notifier).state = null;
         
          }:null,
 
              
         
          decoration: _inputDecoration(tipoSeleccionado != null),
          value: categoriaSeleccionada,
         
        );
      },
      loading: () => const CircularProgressIndicator(), 
      error: (error, stackTrace) => Text('Error: $error'),
    ),
             
            const SizedBox(height: 16),
            const Text('AÑO'),
            const SizedBox(height: 8),
          GestureDetector(
              onTap: () {
                _selectDate(context, ref);
              },
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: anoSeleccionado != null
                      ? DateFormat('dd/MM/yyyy').format(anoSeleccionado) // Formatea la fecha
                      : 'Selecciona una fecha',
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('MES'),
            const SizedBox(height: 8),
       
            const SizedBox(height: 16),
            const Text('DESCRIPCION'),
            const SizedBox(height: 8),
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed('listado');
                },
                child: const Text('Buscar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            
          ],
        ),
      
      ),
      
    );

    

  }
  }
Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (picked != null) {
    ref.read(anoSeleccionadoProvider.notifier).state = picked; // Actualiza el estado de la fecha
  }
}