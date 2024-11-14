import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/presentations/components/navbar.dart';
import 'package:gastapp/presentations/providers/balance_provider.dart';

class BalanceScreen extends ConsumerWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final gastos = ref.watch(getGastosProvider(null));
    final ingresos = ref.watch(getIngresosProvider(null));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico de Barras'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                              // Barra de Gastos
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
                                showingTooltipIndicators: [1],
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
                            gridData: FlGridData(show: true),
                          ),
                        ),
                      );
                    },
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (e, stack) => Center(child: Text('Error: $e')),
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (e, stack) => Center(child: Text('Error: $e')),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}