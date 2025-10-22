part of 'product_bloc.dart';

class ProductState {
  BlocStatus status;
  List<ProductModel> products;
  List<ProductModel> filteredProducts;
  String? errorMessage;
  String? selectedCategory;
  double? minPrice;
  double? maxPrice;
  TextEditingController searchController = TextEditingController();
  ProductState({
    this.status = BlocStatus.initial,
    this.products = const [],
    this.filteredProducts = const [],
    this.errorMessage,
    this.selectedCategory,
    this.maxPrice,
    this.minPrice,
    required this.searchController,
  });

  ProductState copyWith({
    BlocStatus? status,
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
    String? errorMessage,
    String? selectedCategory,
    double? minPrice,
    double? maxPrice,
    TextEditingController? searchController,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      errorMessage: errorMessage ?? this.errorMessage,
      searchController: searchController ?? this.searchController,
      maxPrice: maxPrice??this.maxPrice,
      minPrice: minPrice ?? this.minPrice,
      selectedCategory:  selectedCategory??this.selectedCategory
    );
  }
}
