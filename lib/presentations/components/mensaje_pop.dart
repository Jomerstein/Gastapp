
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void mensajePop(String? mensaje, BuildContext context, bool isSucceed) {
  showDialog(
    context: context,
    builder: (context) =>
    
    
     AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Column(
        children: [
          Icon(
            isSucceed ? Icons.check_circle : Icons.error,
            color: isSucceed ? Colors.green : Colors.red,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            mensaje ?? 'Operación completada',
            style: TextStyle(
              color: isSucceed ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          isSucceed ? '¡Todo salió bien!' : 'Algo salió mal. Intenta nuevamente.',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isSucceed ? Colors.green : Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              if (context.mounted) {
  context.pop();
}
         // Cierra el diálogo
            },
            child: const Text(
              'Continuar',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}