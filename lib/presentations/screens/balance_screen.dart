import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/presentations/components/navbar.dart';
import 'package:gastapp/presentations/providers/balance_provider.dart';

class BalanceScreen extends ConsumerWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 
    final categorias = ref.watch(getCategoriasBalanceProvider);
    final categoriaSeleccionada = ref.watch(categoriaSeleccionadaBalanceProvider);
       final gastos = ref.watch(getGastosProvider(categoriaSeleccionada));
    final ingresos = ref.watch(getIngresosProvider(categoriaSeleccionada));
      double total = 0;
      total = (ingresos.value ?? 0) - (gastos.value ?? 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico de Barras'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                
                Text("Seleccione una categoría", style: TextStyle(fontSize: 25),),
                categorias.when(
                        data: (categorias) {
                            if(categorias.isEmpty){
                        
                                return const Center(
                                  
                                  child: Card(
                                    
                                    child: Text("No hay categorías"),
                                  ),
                                );
                              }
                            
                          return DropdownButtonFormField<String>(
          value: categoriaSeleccionada == null || 
           !categorias.any((categoria) => categoria.nombreCategoria == categoriaSeleccionada)
        ? null // Si la categoría seleccionada es null o no está en la lista, ponerla como null
        : categoriaSeleccionada, // De lo contrario, mostrar la categoría seleccionada
          items: categorias.map((categoria) {
            return DropdownMenuItem<String>(
        value: categoria.nombreCategoria,
        child: Text(categoria.nombreCategoria),
            );
          }).toList(),
          onChanged: (value) {
            // Cuando se cambia la categoría seleccionada, actualizamos el estado
            ref.read(categoriaSeleccionadaBalanceProvider.notifier).state = value;
          },
          decoration:  InputDecoration(
            border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: ()=> ref.read(categoriaSeleccionadaBalanceProvider.notifier).state = null, 
                          child: const Text("Mostrar todo", style: TextStyle(fontSize: 16),)),
                        ],
                      ),
                    Text.rich(
  TextSpan(
    text: "El balance total es: ",
    style: TextStyle(fontSize: 20), 
    children: <TextSpan>[
      TextSpan(
        text: "$total", 
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  ),
),
                gastos.when(
                  data: (gastosValue) {
                    return ingresos.when(
                      data: (ingresosValue) {
                        return SizedBox(
                          width: double.infinity, 
                          height: 300,  
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: (gastosValue > ingresosValue)
                                  ? gastosValue * 1.2
                                  : ingresosValue * 1.2,
                              barGroups: [
                               
                                BarChartGroupData(
                                  x: 0,
                                  
                                  barRods: [
                                    
                                    BarChartRodData(
                                      toY: gastosValue,
                                      color: Colors.red,
                                      width: 20,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ],
                                  showingTooltipIndicators: [0],
                                ),
                                // Barra de Ingresos
                                BarChartGroupData(
                                  x: 1,
                                  barRods: [
                                    BarChartRodData(
                                      toY: ingresosValue,
                                      color: Colors.green,
                                      width: 20,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ],
                                  showingTooltipIndicators: [0],
                                ),
                              ],
                           titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return const Text(
                                            'Gastos', 
                                            style: TextStyle(
                                              fontSize: 14, 
                                              fontWeight: FontWeight.bold, 
                                              color: Colors.black
                                            )
                                          );  // Título para la barra de gastos
                                        case 1:
                                          return const Text(
                                            'Ingresos', 
                                            style: TextStyle(
                                              fontSize: 14, 
                                              fontWeight: FontWeight.bold, 
                                              color: Colors.black
                                            )
                                          );  // Título para la barra de ingresos
                                        default:
                                          return Container(); // Si no hay título
                                      }
                                    },
                                    // Espacio entre el título y el gráfico
                                  ),
                                ),
                              ),
                              gridData: const FlGridData(show: true),
                            ),
                          ),
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, stack) => Center(child: Text('Error: $e')),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, stack) => Center(child: Text('Error: $e')),
                ),
                
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}