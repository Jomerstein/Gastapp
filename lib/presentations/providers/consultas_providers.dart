import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/transaccion.dart';
import 'package:gastapp/core/repositories/repository.dart';
import 'package:gastapp/presentations/providers/firebase.provider.dart';

final tipoSeleccionadoProvider = StateProvider<String?>((ref) => null);
final categoriaSeleccionadaConsultaProvider = StateProvider<String?>((ref) => null);
final anoSeleccionadoProvider = StateProvider<DateTime?>((ref) => null);

final getIngresosFutureProvider = FutureProvider.family<List<Transaccion>, String>((ref, descripcion) async {
  final repository = IngresoRepository(ref.watch(firebaseFirestoreProvider));
  final tipo = ref.watch(tipoSeleccionadoProvider.notifier).state;
  final categoria = ref.watch(categoriaSeleccionadaConsultaProvider.notifier).state;


  if(tipo == "Ingreso"){
      return await repository.getIngresos(descripcion, categoria); 
      
  }else{
    return await repository.getGastos(descripcion,categoria);
    
  }
});

final borrarTransaccionFutureProvider = FutureProvider.family<void,Transaccion>((ref,transaccion) async {
  final repository = IngresoRepository(ref.watch(firebaseFirestoreProvider));
  await repository.deleteTransaccion(transaccion);

});

final loadingProvider = StateProvider<bool>((ref) => false);