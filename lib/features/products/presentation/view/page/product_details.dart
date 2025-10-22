import 'package:fakestoretask/core/services/injection_container.dart';
import 'package:fakestoretask/core/theme/app_colors.dart';
import 'package:fakestoretask/features/cart/data/model/cart_item_model.dart';
import 'package:fakestoretask/features/cart/domain/usecase/add_item_to_cart.dart';
import 'package:fakestoretask/features/products/data/model/product_model.dart';
import 'package:flutter/material.dart';
import '../widgets/rating_star.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetails({super.key, required this.productModel});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.productModel;
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final double descriptionMaxHeight = 200;

    final backgroundGradient = isDark
        ? LinearGradient(
      colors: [AppColors.secondary, Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    )
        : LinearGradient(
      colors: [AppColors.primary, Color(0xFFF8F9FA)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'cart_${product.id}',
        backgroundColor: AppColors.primary,
        elevation: 4,
        onPressed: () async {
          try {
            final addItemUseCase = sl<AddItemToCart>();
            final item = CartItemModel(
              productId: product.id,
              quantity: quantity,
              price: product.price,
              image: product.image,
              name: product.title
            );

            await addItemUseCase.call(1, item);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Added $quantity item(s) to cart ✅"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to add: $e"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const Icon(
          Icons.add_shopping_cart,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(gradient: backgroundGradient)),
          SafeArea(
            child: Column(
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Product Image
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Hero(
                    tag: 'product_${product.id}',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.network(
                        product.image,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Product Details Card
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Price Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  product.title,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.green,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Rating and Category Row
                          Row(
                            children: [
                              buildRatingStars(product.rating.rate),
                              const SizedBox(width: 8),
                              Text(
                                "(${product.rating.count})",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  product.category.toUpperCase(),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Quantity Selector
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Quantity",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    // Decrement Button
                                    InkWell(
                                      onTap: _decrementQuantity,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: quantity > 1
                                              ? AppColors.primary
                                              : Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Quantity Display
                                    Text(
                                      quantity.toString(),
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Increment Button
                                    InkWell(
                                      onTap: _incrementQuantity,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Description (as it was before)
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: descriptionMaxHeight,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withOpacity(0.1)
                                        : Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      product.description,
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}