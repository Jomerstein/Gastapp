import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/repositories/repository.dart';
import 'package:gastapp/presentations/providers/firebase.provider.dart';

final getGastosProvider = StreamProvider.family<double, String?>((ref, categoria) {
  IngresoRepository repositoy = IngresoRepository(ref.read(firebaseFirestoreProvider));
 return repositoy.getGastos(null, categoria, null)?.map((gastos){
    return gastos.fold(0.0, (total, gasto)=> total + gasto.monto);
  })
  ?? const Stream.empty();
});

final getIngresosProvider = StreamProvider.family<double, String?>((ref, categoria) {
  IngresoRepository repositoy = IngresoRepository(ref.read(firebaseFirestoreProvider));
 return repositoy.getIngresos(null, categoria)?.map((gastos){
    return gastos.fold(0.0, (total, gasto)=> total + gasto.monto);
  })
  ?? const Stream.empty();
});