import 'package:isar/isar.dart';

part 'cart_item_model.g.dart';

@embedded
class CartItemModel {
  int productId;
  double price;
  String name;
  String image;
  int quantity;

  CartItemModel({
    this.productId = 0,
    this.quantity = 0,
    this.price = 0.0,
    this.name = '',
    this.image = '',
  });

  CartItemModel copyWith({
    int? productId,
    double? price,
    String? name,
    String? image,
    int? quantity,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      price: price ?? this.price,
      name: name ?? this.name,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}
