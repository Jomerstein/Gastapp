import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/core/models/ingreso.dart';
import 'package:gastapp/core/repositories/repository.dart';
import 'package:gastapp/presentations/providers/firebase.provider.dart';

final tipoSeleccionadoProvider = StateProvider<String?>((ref) => null);
final categoriaSeleccionadaConsultaProvider = StateProvider<String?>((ref) => null);
final anoSeleccionadoProvider = StateProvider<DateTime?>((ref) => null);

final getIngresosFutureProvider = FutureProvider<List<Ingreso>>((ref) async {
  final repository = IngresoRepository(ref.watch(firebaseFirestoreProvider));
  return await repository.getIngresos("este es un gasto");
});