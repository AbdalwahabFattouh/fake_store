import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_bloc.dart';
import '../widgets/custome_bottom_sheet.dart';
import '../widgets/custome_search_bar.dart';
import 'package:fakestoretask/core/theme/app_colors.dart';

class SearchBarComponents extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  const SearchBarComponents({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustemSearchBar(
            controller: searchController,
            onSearch: onSearch,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => ProductFilterBottomSheet(
                  productBloc: context.read<ProductBloc>(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
