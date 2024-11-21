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

final updateCategoriaProvider = FutureProvider.family<void, List<String>>((ref, nombreCategoria) async {
    var repository = IngresoRepository(ref.watch(firebaseFirestoreProvider));
    await repository.updateCategoria(nombreCategoria[0], nombreCategoria[1]);
});


final agregarTransaccionProvider = FutureProvider.autoDispose.family<void, Transaccion>((ref, transaccion) async {
  final firestore = ref.watch(firebaseFirestoreProvider);
  IngresoRepository repository = IngresoRepository(firestore);
  await repository.addTransaccion(transaccion); 
});

final agregarCategoriaProvider = StateNotifierProvider<CategoriaStateNotifier, AsyncValue<void>>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  IngresoRepository repository = IngresoRepository(firestore);
  return CategoriaStateNotifier(repository);
});

class CategoriaStateNotifier extends StateNotifier<AsyncValue<void>> {
  CategoriaStateNotifier(this._repository) : super(const AsyncData(null));

  final IngresoRepository _repository;

  Future<void> agregarCategoria(Categoria categoria) async {
    try {
      state = const AsyncLoading(); 
      await _repository.addCategoria(categoria);
      state = const AsyncData(null); 
    } catch (e, stackTrace) {
      state = AsyncError(e.toString(), stackTrace); 
    }
  }
}






