import 'package:fakestoretask/core/services/injection_container.dart';
import 'package:fakestoretask/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fakestoretask/features/auth/presentation/view/pages/login_page.dart';
import 'package:fakestoretask/features/products/presentation/view/products_view.dart';
import 'package:fakestoretask/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_enum.dart';
class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(CheckLoginStatusEvent()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (!state.splashCompleted) {
            return const SplashPage();
          }

          if (state.isLoggedIn && state.user != null) {
            return const ProductsView();
          }

          return LoginPage();
        },
      ),
    );
  }
}
