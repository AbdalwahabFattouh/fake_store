import 'package:flutter/cupertino.dart';

import '../../../data/model/cart_model.dart';
import '../components/cart_card.dart';

class AnimatedCartItem extends StatelessWidget {
  final CartModel item;
  final int index;

  const AnimatedCartItem({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isEven = index % 2 == 0;
    final offset = isEven ? Offset(1.0, 0.0) : Offset(-1.0, 0.0);

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        // تأكد من أن القيمة بين 0.0 و 1.0
        final clampedValue = value.clamp(0.0, 1.0);
        final opacityValue = clampedValue.toDouble();

        return Transform.translate(
          offset: Offset(offset.dx * (1 - opacityValue) * 100, 0),
          child: Opacity(
            opacity: opacityValue,
            child: child,
          ),
        );
      },
      child: CartCard(item: item),
    );
  }
}