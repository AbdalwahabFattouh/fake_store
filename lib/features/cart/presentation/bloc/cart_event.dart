part of 'cart_bloc.dart';

class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCartsEvent extends CartEvent {}

class DeleteCartEvent extends CartEvent {
  final int cartId;

  DeleteCartEvent(this.cartId);

  @override
  List<Object?> get props => [cartId];
}

class ClearCartItemsEvent extends CartEvent {
  final int cartId;

  ClearCartItemsEvent(this.cartId);

  @override
  List<Object?> get props => [cartId];
}

class RemoveItemFromCartEvent extends CartEvent {
  final int cartId;
  final int productId;

  RemoveItemFromCartEvent(this.cartId, this.productId);

  @override
  List<Object?> get props => [cartId, productId];
}

class UpdateItemQuantityEvent extends CartEvent {
  final int cartId;
  final int productId;
  final int newQuantity;

  UpdateItemQuantityEvent(this.cartId, this.productId, this.newQuantity);

  @override
  List<Object?> get props => [cartId, productId, newQuantity];
}

class CheckoutCartEvent extends CartEvent {
  final int cartId;

  CheckoutCartEvent(this.cartId);

  @override
  List<Object?> get props => [cartId];
}
