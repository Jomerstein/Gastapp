import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/transaccion.dart';
import 'package:gastapp/core/repositories/repository.dart';
import 'package:gastapp/presentations/providers/firebase.provider.dart';

final tipoSeleccionadoProvider = StateProvider<String?>((ref) => null);
final categoriaSeleccionadaConsultaProvider = StateProvider<String?>((ref) => null);
final anioSeleccionadoProvider = StateProvider<DateTime?>((ref) => null);
final descripcionSeleccionadaProvider = StateProvider<String?>((ref) => null);


final borrarTransaccionFutureProvider = FutureProvider.family<void,Transaccion>((ref,transaccion) async {
  final repository = IngresoRepository(ref.watch(firebaseFirestoreProvider));
  await repository.deleteTransaccion(transaccion);

});

final loadingProvider = StateProvider<bool>((ref) => false);