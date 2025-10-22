part of 'cart_bloc.dart';

class CartState {
  BlocStatus status;
  List<CartModel> carts;
  String? errorMessage;

  CartState({
    this.status = BlocStatus.initial,
    this.carts = const [],
    this.errorMessage,
  });
  CartState copyWith({
    BlocStatus? status,
    List<CartModel>? carts,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      carts: carts ?? this.carts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
