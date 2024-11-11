import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/core/models/gasto.dart';
import 'package:gastapp/core/models/ingreso.dart';
import 'package:gastapp/presentations/components/navbar.dart';
import 'package:gastapp/presentations/providers/gastos_ingresos_provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';



class GastosIngresosScreen extends ConsumerWidget {
  GastosIngresosScreen({super.key});

  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController montoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categorias = ref.watch(getCategoriasProvider);

    final TextEditingController _dateController = TextEditingController();

  
     return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ingresos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
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
                   decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)
            ),
                    
            hintStyle: const TextStyle(color: Colors.grey)
                    ),
                 onChanged: (stri)=>{
                  ref.read(descripcionProvider.notifier).state = stri
                 },             ),
                const SizedBox(height: 16),
                const Text('TIPO DE MONEDA'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  items: ['ARS']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (value) {
                    ref.read(monedaSeleccionadaProvider.notifier).state = value;
                  },
                    decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)
            ),
                     
            hintStyle: const TextStyle(color: Colors.grey)
                    ),
                ),
                const SizedBox(height: 16),
                const Text('MONTO'),
                const SizedBox(height: 8),
                TextField(
                  controller: montoController,
                  decoration: InputDecoration(
                    prefixText: '\$',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value)=>{
                    ref.read(montoProvider.notifier).state = double.tryParse(value) ?? 0
                  },
                ),
                const SizedBox(height: 16,),
                const Text("Fecha"),
                const SizedBox(height: 8,),
              TextField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
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
                      ref.read(selectedDateProvider.notifier).state = selectedDate;
                      _dateController.text = 
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                    }
                  },
                ),
                    
                const SizedBox(height: 16,),
                const Text('CATEGORIA'),
                const SizedBox(height: 8),
                Column(
                  children: [
                    categorias.when(
                      data: (categorias) {
                          if(categorias.isEmpty){
                            // hacer la card modularizada 
                              return Card(child: Text("NoHay"),);
                            }
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
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                    const SizedBox(height: 6,),
                  
                    ElevatedButton(
                      onPressed: () => _showFormularioDialog(context, ref), // Llama a la función para mostrar el diálogo
                          child: const Text('Agregar categoría'),
                            ),
                    
                  ],
                  
                ),
                    
                
                
                const Spacer(),
                
                
                const Align(
                  alignment: Alignment.center,
                  child: _BotonTransaccion(),
                  )
               
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(),
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
              Categoria categoria = Categoria(id: "", nombreCategoria: nombreCategoria, userId: FirebaseAuth.instance.currentUser!.email ?? "");
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

  const _BotonTransaccion();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
                onPressed: () {
                  String tipoDeMoneda = ref.read(monedaSeleccionadaProvider.notifier).state.toString();
                  String categoria = ref.read(categoriaSeleccionadaProvider.notifier).state.toString();
                  double monto  = ref.read(montoProvider.notifier).state.toDouble();
                  String descripcion = ref.read(descripcionProvider.notifier).state.toString();
                  DateTime? fecha = ref.read(selectedDateProvider.notifier).state;
                  User? currentUser = FirebaseAuth.instance.currentUser;
                  if(currentUser != null){
                    
                  
                  if(ref.read(tipoTransaccionProvider.notifier).state == "Gasto"){
                    Gasto gasto = Gasto(
                      descripcion: descripcion,
                      tipoDeMoneda: tipoDeMoneda,
                      monto: monto,
                      categoria: categoria,
                      userId: currentUser.email!,
                      fecha: fecha!,
                    );
                    ref.read(agregarTransaccionProvider(gasto));
                  }else{
                    Ingreso ingreso = Ingreso(
                      descripcion: descripcion,
                      tipoDeMoneda: tipoDeMoneda,
                      monto: monto,
                      categoria: categoria,
                      userId: currentUser.email!,
                      fecha: fecha!,
                  
                    );
                    ref.read(agregarTransaccionProvider(ingreso));
                  }
                }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Agregar transacción'),
              );
            
  }
}

