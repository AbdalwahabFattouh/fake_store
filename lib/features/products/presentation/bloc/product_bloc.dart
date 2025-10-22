import 'package:equatable/equatable.dart';
import 'package:fakestoretask/core/errors/failures.dart';
import 'package:fakestoretask/core/utils/app_enum.dart';
import 'package:fakestoretask/features/products/data/model/product_model.dart';
import 'package:fakestoretask/features/products/domain/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository})
    : super(ProductState(searchController: TextEditingController())) {
    on<FetchProductsEvent>(_fetchProducts);
    on<SearchProductsEvent>(_searchProducts);
    on<ApplyFilterEvent>(_applyFilter);
  }
  Future<void> _applyFilter(
      ApplyFilterEvent event,
      Emitter<ProductState> emit,
      ) async {
    final query = state.searchController.text.toLowerCase();
    List<ProductModel> filtered = state.products;

    // فلترة حسب الفئة
    if (event.category != null && event.category!.isNotEmpty) {
      filtered = filtered
          .where((p) => p.category.toLowerCase() == event.category!.toLowerCase())
          .toList();
    }

    // فلترة حسب السعر
    if (event.minPrice != null) {
      filtered = filtered.where((p) => p.price >= event.minPrice!).toList();
    }
    if (event.maxPrice != null) {
      filtered = filtered.where((p) => p.price <= event.maxPrice!).toList();
    }

    // فلترة حسب البحث
    if (query.isNotEmpty) {
      filtered = filtered
          .where((p) => p.title.toLowerCase().contains(query))
          .toList();
    }

    emit(state.copyWith(
      filteredProducts: filtered,
      selectedCategory: event.category,
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
    ));
  }

  Future<void> _fetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    print("fetchProducts");
    emit(state.copyWith(status: BlocStatus.loading, errorMessage: null));
    try {
      final products = await productRepository.getProducts();
      emit(state.copyWith(status: BlocStatus.success, products: products));
    } on Failure catch (e) {
      emit(
        state.copyWith(status: BlocStatus.failed, errorMessage: e.toString()),
      );
    } catch (e) {
      print("errrror :: $e");
      emit(
        state.copyWith(
          status: BlocStatus.failed,
          errorMessage: 'Unexpected error',
        ),
      );
    }
  }

  Future<void> _searchProducts(
    SearchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    final query = event.query.toLowerCase();
    final filteredProducts = state.products
        .where((product) => product.title.toLowerCase().contains(query))
        .toList();
    emit(state.copyWith(filteredProducts: filteredProducts));
  }
}
