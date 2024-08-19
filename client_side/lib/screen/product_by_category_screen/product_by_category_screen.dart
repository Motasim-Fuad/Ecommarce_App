import 'package:sad/main.dart';
import 'package:sad/utility/extensions.dart';

import '../../models/brand.dart';
import '../../models/category.dart';
import '../../models/sub_category.dart';
import 'provider/product_by_category_provider.dart';
import '../../utility/app_color.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/multi_select_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/horizondal_list.dart';
import '../../widget/product_grid_view.dart';

class ProductByCategoryScreen extends StatelessWidget {
  final Category selectedCategory;

  const ProductByCategoryScreen({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      context.proByCProvider.filterInitialProductAndSubCategory(selectedCategory);
    });
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text(
                "${selectedCategory.name}",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.darkOrange),
              ),
              expandedHeight: 190.0,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  var top = constraints.biggest.height - MediaQuery.of(context).padding.top;
                  return Stack(
                    children: [
                      Positioned(
                        top: top - 145,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Consumer<ProductByCategoryProvider>(
                              builder: (context, proByCatProvider, child) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: HorizontalList(
                                    items: proByCatProvider.subCategories,
                                    itemToString: (SubCategory? val) => val?.name ?? '',
                                    selected: proByCatProvider.mySelectedSubCategory,
                                    onSelect: (val) {
                                      if (val != null) {
                                        context.proByCProvider.filterProductBySubCategory(val);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown<String>(
                                    hintText: 'Sort By Price',
                                    items: const ['Low To High', 'High To Low'],
                                    onChanged: (val) {
                                      if (val?.toLowerCase() == 'low to high') {
                                        context.proByCProvider.sortProducts(ascending: true);
                                        //TODO: should complete call sortProducts (ascending: true)
                                      } else {
                                        context.proByCProvider.sortProducts(ascending: false);
                                        //TODO: should complete call sortProducts (ascending: false)
                                      }
                                    },
                                    displayItem: (val) => val,
                                  ),
                                ),
                                Expanded(
                                  child: Consumer<ProductByCategoryProvider>(
                                    builder: (context, proByCatProvider, child) {
                                      return MultiSelectDropDown<Brand>(
                                        hintText: 'Filter By Brands',
                                        items: proByCatProvider.brands,
                                        onSelectionChanged: (val) {
                                          proByCatProvider.selectedBrands = val;
                                          context.proByCProvider.filterProductByBrand();
                                          proByCatProvider.updateUI();
                                        },
                                        displayItem: (val) => val.name ?? '',
                                        selectedItems: proByCatProvider.selectedBrands,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: Consumer<ProductByCategoryProvider>(
                  builder: (context, proByCaProvider, child) {
                    return ProductGridView(
                      items: proByCaProvider.filteredProduct,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
