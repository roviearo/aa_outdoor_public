import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/router.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/entities.dart';
import '../blocs/category/category_bloc.dart';
import '../blocs/equipment/equipment_bloc.dart';
import '../cubits/equipment_shared_prefs/equipment_shared_prefs_cubit.dart';
import '../widget/detail_equipment_modal_bottom_sheet.dart';
import '../widget/equipment_category_card.dart';
import '../widget/equipment_grid_card.dart';
import '../widget/equipment_list_card.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<EquipmentSharedPrefsCubit, EquipmentSharedPrefsState>(
        builder: (context, state) {
          final prefs = state;
          return Column(
            children: [
              const CustomAppBar(useLogo: true),
              IntrinsicHeight(
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: InkWell(
                        onTap: () {
                          if (prefs.equipmentView == 0) {
                            context
                                .read<EquipmentSharedPrefsCubit>()
                                .writeEquipmentView(1);
                          } else {
                            context
                                .read<EquipmentSharedPrefsCubit>()
                                .writeEquipmentView(0);
                          }
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            prefs.equipmentView == 0
                                ? 'icons/list_view.svg'
                                : 'icons/equipment_outline.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            EquipmentCategoryCard(
                              onTap: prefs.equipmentCategory != -1
                                  ? () {
                                      context
                                          .read<EquipmentSharedPrefsCubit>()
                                          .writeEquipmentCategory(-1);
                                      context
                                          .read<EquipmentBloc>()
                                          .add(const LoadListEquipment());
                                    }
                                  : () {},
                              isSelected: prefs.equipmentCategory == -1,
                              name: 'Semua',
                            ),
                            BlocBuilder<CategoryBloc, CategoryState>(
                              builder: (context, state) {
                                if (state is ListCategoryLoaded) {
                                  final listCategory = state.listCategory;

                                  return Row(
                                    children: List.generate(
                                      listCategory.length,
                                      (index) => EquipmentCategoryCard(
                                        onTap: prefs.equipmentCategory != index
                                            ? () {
                                                context
                                                    .read<
                                                        EquipmentSharedPrefsCubit>()
                                                    .writeEquipmentCategory(
                                                        index);
                                                context
                                                    .read<EquipmentBloc>()
                                                    .add(LoadListEquipment(
                                                        categoryId:
                                                            listCategory[index]
                                                                .id));
                                              }
                                            : () {},
                                        isSelected:
                                            prefs.equipmentCategory == index,
                                        name: listCategory[index].name,
                                      ),
                                    ),
                                  );
                                }
                                return const Center(child: Text('Error'));
                              },
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<EquipmentBloc, EquipmentState>(
                  builder: (context, state) {
                    if (state is EquipmentLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DeleteEquipmentError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                      router.pop();
                    }

                    if (state is DeleteEquipmentSucceeded) {
                      context
                          .read<EquipmentSharedPrefsCubit>()
                          .writeEquipmentCategory(-1);
                      context
                          .read<EquipmentBloc>()
                          .add(const LoadListEquipment());
                    }

                    if (state is ListEquipmentLoaded) {
                      final listEquipment = state.listEquipment;

                      List<TrackSize> rowSizes = [];
                      for (int i = 0; i < listEquipment.length / 3; i++) {
                        rowSizes.add(auto);
                      }

                      if (listEquipment.isEmpty) {
                        return const Center(
                          child: Text('Tidak ada data'),
                        );
                      }

                      return prefs.equipmentView == 0
                          ? ListEquipment(
                              listEquipment: listEquipment,
                            )
                          : GridEquipment(
                              rowSizes: rowSizes,
                              listEquipment: listEquipment,
                            );
                    }

                    return const Center(child: Text('Error'));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class GridEquipment extends StatelessWidget {
  const GridEquipment({
    super.key,
    required this.rowSizes,
    required this.listEquipment,
  });

  final List<TrackSize> rowSizes;
  final List<Equipment> listEquipment;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      children: [
        LayoutGrid(
          columnSizes: [1.fr, 1.fr, 1.fr],
          rowSizes: rowSizes,
          rowGap: 10,
          columnGap: 10,
          children: List.generate(
            listEquipment.length,
            (index) => EquipmentGridCard(
              name: listEquipment[index].name,
              price: listEquipment[index].price,
              stockQty: listEquipment[index].stockQty,
              onTap: () => _equipmentDetailModalBottomSheet(
                  context, listEquipment[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class ListEquipment extends StatelessWidget {
  const ListEquipment({
    super.key,
    required this.listEquipment,
  });

  final List<Equipment> listEquipment;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 25),
      itemCount: listEquipment.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: EquipmentListCard(
          title: listEquipment[index].name,
          stock: listEquipment[index].stockQty.toString(),
          price: listEquipment[index].price,
          onTap: () =>
              _equipmentDetailModalBottomSheet(context, listEquipment[index]),
        ),
      ),
    );
  }
}

Future<dynamic> _equipmentDetailModalBottomSheet(
    BuildContext context, Equipment equipment) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useRootNavigator: true,
    builder: (_) => DetailEquipmentModalBottomSheet(
      equipment: equipment,
    ),
  );
}
