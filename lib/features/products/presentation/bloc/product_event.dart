part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {}

class SearchProductsEvent extends ProductEvent {
  final String query;
  const SearchProductsEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
class ApplyFilterEvent extends ProductEvent {
  final String? category;
  final double? minPrice;
  final double? maxPrice;

  const ApplyFilterEvent({this.category, this.minPrice, this.maxPrice});
}
