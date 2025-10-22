import 'package:fakestoretask/core/services/injection_container.dart';
import 'package:fakestoretask/features/cart/presentation/view/carts_view.dart';
import 'package:fakestoretask/features/products/presentation/bloc/product_bloc.dart';
import 'package:fakestoretask/features/products/presentation/view/components/bottom_navigation_bar.dart';
import 'package:fakestoretask/features/products/presentation/view/page/product_body.dart';
import 'package:fakestoretask/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  int _currentBottomNavIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => sl<ProductBloc>()..add(FetchProductsEvent()),
      child: Scaffold(
        body: IndexedStack(
          index: _currentBottomNavIndex,
          children: [
            const ProductBody(),
            const CartsView(),
            const ProfileView()
          ],
        ),
        bottomNavigationBar: AdvancedBottomNavigationBar(
          currentIndex: _currentBottomNavIndex,
          onTabChanged: _onTabChanged,
        ),
      ),
    );
  }
}
