import 'package:fakestoretask/core/components/loading_page.dart';
import 'package:fakestoretask/core/theme/app_colors.dart';
import 'package:fakestoretask/core/utils/app_enum.dart';
import 'package:fakestoretask/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fakestoretask/features/cart/presentation/view/components/carts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartsPage extends StatelessWidget {
  const CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carts'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          switch (state.status) {
            case BlocStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case BlocStatus.loading:
              return AdvancedLoadingScreen(
                title: "Loading",
                subtitle: "Please wait...",
                type: LoadingType.pulse,
                primaryColor: AppColors.primary,
                secondaryColor: AppColors.accent,
              );
            case BlocStatus.success:
              return RefreshIndicator(
                backgroundColor: AppColors.primary,
                color: Colors.white,
                displacement: 40,
                strokeWidth: 3,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  context.read<CartBloc>().add(LoadCartsEvent());
                  await Future.delayed(const Duration(milliseconds: 1500));
                },
                child: CartsList(carts: state.carts),
              );
            case BlocStatus.failed:
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<CartBloc>().add(LoadCartsEvent());
                  await Future.delayed(const Duration(milliseconds: 1500));
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.errorMessage ?? 'An error occurred',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<CartBloc>().add(LoadCartsEvent());
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}