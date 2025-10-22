import 'package:fakestoretask/features/cart/data/model/cart_item_model.dart';
import 'package:isar/isar.dart';
part 'cart_model.g.dart';

@collection
class CartModel {
  Id id = Isar.autoIncrement;
  int userId;
  DateTime date;
  List<CartItemModel> products;
  bool isActive = true;

  CartModel({
    required this.userId,
    required this.date,
    required this.products,
    required this.isActive,
  });

  CartModel copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<CartItemModel>? products,
    bool? isActive,
  }) {
    return CartModel(
      userId: userId ?? this.userId,
      date: date ?? this.date,
      products: products ?? List<CartItemModel>.from(this.products),
      isActive: isActive ?? this.isActive,
    )..id = id ?? this.id;
  }
}
