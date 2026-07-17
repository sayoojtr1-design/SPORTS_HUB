import 'package:e_store/features/shop/model/category_model.dart';
import 'package:e_store/features/shop/view/widgets/category_chip.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryModel> categories;
  final int selectedCategoryId;
  final Function(int) onCategorySelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CategoryChip(
              title: "All",
              isSelected: selectedCategoryId == 0,
              onTap: () => onCategorySelected(0),
            );
          }
          final category = categories[index - 1];
          return CategoryChip(
              title: category.name ?? "",
              isSelected: selectedCategoryId == category.id
              , onTap: ()=> onCategorySelected(category.id!));
        },
      ),
    );
  }
}