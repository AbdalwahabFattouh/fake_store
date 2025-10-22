import 'package:fakestoretask/core/services/injection_container.dart';
import 'package:fakestoretask/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fakestoretask/features/cart/presentation/view/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartsView extends StatelessWidget {
  const CartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CartBloc>()..add(LoadCartsEvent()),
      child: CartsPage(),
    );
  }
}
