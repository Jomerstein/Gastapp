
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastapp/presentations/components/navbar.dart';
import 'package:gastapp/presentations/providers/balance_provider.dart';

class BalanceScreen extends ConsumerWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final gastos = ref.watch(getGastosProvider(null));
     return  Scaffold(
        body: Padding(padding: const EdgeInsets.all(16),
        child: Center(
            
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                ],
            ),
        ),),
        bottomNavigationBar: const Navbar(),
    );
  }
}