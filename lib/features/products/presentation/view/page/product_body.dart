import 'package:fakestoretask/core/components/loading_page.dart';
import 'package:fakestoretask/core/utils/app_enum.dart';
import 'package:fakestoretask/features/products/data/model/product_model.dart';
import 'package:fakestoretask/features/products/presentation/bloc/product_bloc.dart';
import 'package:fakestoretask/features/products/presentation/view/components/product_grid.dart';
import 'package:fakestoretask/features/products/presentation/view/components/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({super.key});

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductsEvent());
  }

  void _applyFilter({required String query}) {
    context.read<ProductBloc>().add(SearchProductsEvent(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        switch (state.status) {
          case BlocStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case BlocStatus.loading:
            return const AdvancedLoadingScreen(
              title: "جاري التحميل",
              subtitle: "يرجى الانتظار قليلاً",
              type: LoadingType.dots,
              primaryColor: Colors.blue,
              secondaryColor: Colors.purple,
            );
          case BlocStatus.failed:
            return Center(child: Text(state.errorMessage ?? 'Error'));
          case BlocStatus.success:
            final List<ProductModel> productsToShow =
                state.filteredProducts.isNotEmpty
                ? state.filteredProducts
                : state.products;
            return Padding(
              padding: const EdgeInsets.only(top: 45,left: 16,right: 16),
              child: Column(
                children: [
                  SearchBarComponents(
                    searchController: state.searchController,
                    onSearch: (query) => _applyFilter(query: query),
                  ),
                  const SizedBox(height: 12),
                  Expanded(child: ProductGrid(products: productsToShow)),
                ],
              ),
            );
        }
      },
    );
  }
}
