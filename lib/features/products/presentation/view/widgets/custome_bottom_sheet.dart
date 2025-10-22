import 'package:flutter/material.dart';
import '../../bloc/product_bloc.dart';
import 'package:fakestoretask/core/theme/app_colors.dart';

class ProductFilterBottomSheet extends StatefulWidget {
  final ProductBloc productBloc;
  final String? currentCategory;
  final double? currentMinPrice;
  final double? currentMaxPrice;

  const ProductFilterBottomSheet({
    super.key,
    required this.productBloc,
    this.currentCategory,
    this.currentMinPrice,
    this.currentMaxPrice,
  });

  @override
  State<ProductFilterBottomSheet> createState() => _ProductFilterBottomSheetState();
}

class _ProductFilterBottomSheetState extends State<ProductFilterBottomSheet> {
  late String? selectedCategory;
  late double? minPrice;
  late double? maxPrice;

  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;

  final List<String> categories = [
    "men's clothing",
    "women's clothing",
    "electronics",
    "jewelery",
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.currentCategory;
    minPrice = widget.currentMinPrice;
    maxPrice = widget.currentMaxPrice;

    minPriceController = TextEditingController(text: minPrice?.toString() ?? '');
    maxPriceController = TextEditingController(text: maxPrice?.toString() ?? '');
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    "Filter Products",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedCategory = null;
                    minPriceController.clear();
                    maxPriceController.clear();
                    minPrice = null;
                    maxPrice = null;
                  });
                  Navigator.pop(context);
                  widget.productBloc.add(
                    ApplyFilterEvent(category: null, minPrice: null, maxPrice: null),
                  );
                },
                icon: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Categories using Wrap and Chips
          const Text("Category", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: categories.map((category) {
              final isSelected = selectedCategory == category;
              return ChoiceChip(
                label: Text(category
                    .replaceAll("men's clothing", "Men's Clothing")
                    .replaceAll("women's clothing", "Women's Clothing")
                    .replaceAll("electronics", "Electronics")
                    .replaceAll("jewelery", "Jewelery")),
                selected: isSelected,
                onSelected: (_) => setState(() {
                  selectedCategory = isSelected ? null : category;
                }),
                selectedColor: AppColors.primary,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Price range using Row and TextField
          const Text("Price Range", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: minPriceController,
                  decoration: InputDecoration(
                    labelText: "Min Price",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) => minPrice = double.tryParse(val),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: maxPriceController,
                  decoration: InputDecoration(
                    labelText: "Max Price",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) => maxPrice = double.tryParse(val),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Apply button only
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.productBloc.add(
                  ApplyFilterEvent(
                    category: selectedCategory,
                    minPrice: minPrice,
                    maxPrice: maxPrice,
                  ),
                );
              },
              child: const Text("Apply Filters"),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}