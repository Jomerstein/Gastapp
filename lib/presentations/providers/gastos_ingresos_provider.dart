import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/categoria.dart';
import 'package:gastapp/core/models/transaccion.dart';
import 'package:gastapp/core/repositories/repository.dart';
import 'package:gastapp/presentations/providers/firebase.provider.dart';



// Este provider controla si el tipo de transacción es 'Gasto' o 'Ingreso'
final tipoTransaccionProvider = StateProvider<String>((ref) => 'Ingreso');
final monedaSeleccionadaProvider = StateProvider<String?>((ref) => null);
final descripcionProvider = StateProvider<String?>((ref) => null);
final montoProvider = StateProvider<double>((ref) => 0);
final categoriaSeleccionadaProvider = StateProvider<String?>((ref)=> null);
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

final getCategoriasProvider = StreamProvider<List<Categoria>>((ref) {
  final repository = IngresoRepository(ref.watch(firebaseFirestoreProvider));
  return repository.getCategorias();
});
final borrarCategoriaProvider = FutureProvider.family<void,String>((ref,nombreCategoria) async {
  final repository = IngresoRepository(ref.watch(firebaseFirestoreProvider));
  await repository.deleteCategoria(nombreCategoria);

}); 


final agregarTransaccionProvider = FutureProvider.autoDispose.family<void, Transaccion>((ref, transaccion) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  IngresoRepository repository = IngresoRepository(firestore);
  repository.addTransaccion(transaccion); 
});

final agregarCategoriaProvider = FutureProvider.autoDispose.family<void, Categoria>((ref, categoria) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  IngresoRepository repository = IngresoRepository(firestore);
  
  return repository.addCategoria(categoria); 
});






