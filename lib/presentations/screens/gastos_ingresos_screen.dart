import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/core/models/gasto.dart';
import 'package:gastapp/core/models/ingreso.dart';
import 'package:gastapp/presentations/providers/gastos_ingresos_provider.dart';

import 'package:intl/intl.dart';


class GastosIngresosScreen extends ConsumerWidget {
  GastosIngresosScreen({super.key});

  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController montoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categorias = ref.watch(getCategoriasProvider);
     final selectedDate = ref.watch(selectedDateProvider);
  
  
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ingresos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => ref.read(tipoTransaccionProvider.notifier).state = "Gasto",
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: ref.watch(tipoTransaccionProvider) == "Gasto" ? Colors.red : Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Gasto',
                        style: TextStyle(
                          fontSize: 18,
                          color: ref.watch(tipoTransaccionProvider) == "Gasto" ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => ref.read(tipoTransaccionProvider.notifier).state = "Ingreso",
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: ref.watch(tipoTransaccionProvider) == "Ingreso" ? Colors.green : Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Ingreso',
                        style: TextStyle(
                          fontSize: 18,
                          color: ref.watch(tipoTransaccionProvider) == "Ingreso" ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('DESCRIPCION'),
            const SizedBox(height: 8),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
             onChanged: (stri)=>{
              ref.read(descripcionProvider.notifier).state = stri
             },             ),
            const SizedBox(height: 16),
            const Text('TIPO DE MONEDA'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              items: ['USD', 'ARS']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                ref.read(monedaSeleccionadaProvider.notifier).state = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('MONTO'),
            const SizedBox(height: 8),
            TextField(
              controller: montoController,
              decoration: const InputDecoration(
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value)=>{
                ref.read(montoProvider.notifier).state = double.tryParse(value) ?? 0
              },
            ),
            const SizedBox(height: 16),
            const Text('CATEGORIA'),
            const SizedBox(height: 8),
            Column(
              children: [
                categorias.when(
                  data: (categorias) {
                    return DropdownButtonFormField<String>(
                      items: categorias.map((categoria) {
                        return DropdownMenuItem<String>(
                          value: categoria.nombreCategoria,
                          child: Text(categoria.nombreCategoria),
                        );
                      }).toList(),
                      onChanged: (value) {
                        ref.read(categoriaSeleccionadaProvider.notifier).state = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Text('Error: $error'),
                ),
                ElevatedButton(
                  onPressed: () => _showFormularioDialog(context, ref), // Llama a la función para mostrar el diálogo
                      child: const Text('Agregar categoría'),
                        ),
              ],
              
            ),
            const SizedBox(height: 16,),
               const Text('FECHA'),
            
              const Spacer(),
            
            
            const Align(
              alignment: Alignment.center,
              child: _BotonTransaccion(),
              )
           
          ],
        ),
      ),
    );
  }
  
}




void _showFormularioDialog(BuildContext context, WidgetRef ref) {
  final TextEditingController nombreController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Agregar categoría'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la categoría',
                ),
              ),
              // Puedes añadir más campos según sea necesario
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String nombreCategoria = nombreController.text;
              Categoria categoria = Categoria(id: "", nombreCategoria: nombreCategoria);
              ref.read(agregarCategoriaProvider(categoria));
              
              Navigator.of(context).pop(); // Cierra el diálogo
            },
            child: const Text('Enviar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
}
    
 





class _BotonTransaccion extends ConsumerWidget {

  const _BotonTransaccion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
                onPressed: () {
                  String tipoDeMoneda = ref.read(monedaSeleccionadaProvider.notifier).state.toString();
                  String categoria = ref.read(categoriaSeleccionadaProvider.notifier).state.toString();
                  double monto  = ref.read(montoProvider.notifier).state.toDouble();
                  String descripcion = ref.read(descripcionProvider.notifier).state.toString();
            
                  if(ref.read(tipoTransaccionProvider.notifier).state == "Gasto"){
                    Gasto gasto = Gasto(
                      descripcion: descripcion,
                      tipoDeMoneda: tipoDeMoneda,
                      monto: monto,
                      categoria: categoria, id: ''
                    );
                    ref.read(agregarTransaccionProvider(gasto));
                  }else{
                    Ingreso ingreso = Ingreso(
                      descripcion: descripcion,
                      tipoDeMoneda: tipoDeMoneda,
                      monto: monto,
                      categoria: categoria, id: '',
                  
                    );
                    ref.read(agregarTransaccionProvider(ingreso));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Agregar transacción'),
              );
            
  }
}

