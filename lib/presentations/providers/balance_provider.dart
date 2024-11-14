import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/core/repositories/repository.dart';
import 'package:gastapp/presentations/providers/firebase.provider.dart';

final getGastosProvider = StreamProvider.family<double, String?>((ref, categoria) {
  IngresoRepository repositoy = IngresoRepository(ref.read(firebaseFirestoreProvider));
  final gastos = repositoy.getGastos(null, categoria, null);
  if(gastos == null){
   return const Stream.empty();
  }else{
    return  gastos.map((gastos){
    return gastos.fold(0.0, (total, gasto)=> total + gasto.monto);
  });
  }
  
 
});

final getIngresosProvider = StreamProvider.family<double, String?>((ref, categoria) {
  IngresoRepository repositoy = IngresoRepository(ref.read(firebaseFirestoreProvider));
  final ingresos = repositoy.getIngresos(null, categoria, null);

  if(ingresos == null){
    return const Stream.empty();
  }else{
    return  ingresos.map((ingresos){
    return ingresos.fold(0.0, (total, ingreso)=> total + ingreso.monto);
  });
  }
});

final getCategoriasBalanceProvider = StreamProvider<List<Categoria>>((ref) {
  final repository = IngresoRepository(ref.watch(firebaseFirestoreProvider));
  return repository.getCategorias();
});

final categoriaSeleccionadaBalanceProvider = StateProvider<String?>((ref) => null);