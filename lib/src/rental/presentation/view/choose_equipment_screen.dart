import 'package:aa_outdoor/src/equipment/presentation/cubits/search_equipment/search_equipment_cubit.dart';
import 'package:aa_outdoor/src/rental/presentation/widget/search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../core/utils/router.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../../../equipment/presentation/blocs/category/category_bloc.dart';
import '../../../equipment/presentation/blocs/equipment/equipment_bloc.dart';
import '../../../equipment/presentation/cubits/equipment_shared_prefs/equipment_shared_prefs_cubit.dart';
import '../../../equipment/presentation/widget/equipment_category_card.dart';
import '../../../package/presentation/cubit/packages/packages_cubit.dart';
import '../cubit/add_rental/add_rental_cubit.dart';
import '../widget/equipment_grid_card.dart';
import '../widget/equipment_list_card.dart';
import '../widget/package_list_card.dart';

class ChooseEquipmentScreen extends StatefulWidget {
  const ChooseEquipmentScreen({super.key});

  @override
  State<ChooseEquipmentScreen> createState() => _ChooseEquipmentScreenState();
}

class _ChooseEquipmentScreenState extends State<ChooseEquipmentScreen> {
  int selectedIndex = -1;
  int selectedView = 0;
  bool isSearchOpen = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<AddRentalCubit, AddRentalState>(
          builder: (context, state) {
            final addRentalState = state;

            return PopScope(
              canPop: true,
              onPopInvokedWithResult: (didPop, result) =>
                  context.read<AddRentalCubit>().clearAddRental(),
              child: SafeArea(
                child: Stack(
                  children: [
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const BackButton(),
                                Text(
                                  'Pilih Peralatan',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (selectedView != 0) {
                                      setState(() {
                                        selectedView = 0;
                                      });
                                    } else {
                                      setState(() {
                                        selectedView = 1;
                                      });
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    selectedView == 0
                                        ? 'icons/list_view.svg'
                                        : 'icons/equipment_outline.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TabBar(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            unselectedLabelStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline),
                            dividerColor: Colors.transparent,
                            tabs: const [
                              Tab(
                                child: Text('Peralatan'),
                              ),
                              Tab(
                                child: Text('Paket'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: TabBarView(children: [
                              // Equipment
                              Column(
                                children: [
                                  isSearchOpen
                                      ? const SizedBox.shrink()
                                      : const SizedBox(height: 5),
                                  isSearchOpen
                                      ? SearchForm(
                                          onTap: () => setState(() {
                                            isSearchOpen = false;
                                          }),
                                        )
                                      : BlocBuilder<CategoryBloc,
                                          CategoryState>(
                                          builder: (context, state) {
                                            if (state is CategoryError) {
                                              return Center(
                                                  child: Text(state.messages));
                                            }

                                            if (state is ListCategoryLoaded) {
                                              final listCategory =
                                                  state.listCategory;
                                              return IntrinsicHeight(
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 16),
                                                    Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryContainer,
                                                      child: InkWell(
                                                        onTap: () =>
                                                            setState(() {
                                                          isSearchOpen = true;
                                                        }),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            'icons/search.svg',
                                                            colorFilter:
                                                                ColorFilter
                                                                    .mode(
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
                                                    BlocBuilder<
                                                        EquipmentSharedPrefsCubit,
                                                        EquipmentSharedPrefsState>(
                                                      builder:
                                                          (context, state) {
                                                        var prefs = state;
                                                        return Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Row(
                                                                children: [
                                                                  EquipmentCategoryCard(
                                                                    onTap: prefs.equipmentCategory !=
                                                                            -1
                                                                        ? () {
                                                                            context.read<EquipmentSharedPrefsCubit>().writeEquipmentCategory(-1);
                                                                            context.read<EquipmentBloc>().add(const LoadListEquipment());
                                                                          }
                                                                        : () {},
                                                                    isSelected:
                                                                        prefs.equipmentCategory ==
                                                                            -1,
                                                                    name:
                                                                        'Semua',
                                                                  ),
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          listCategory
                                                                              .length;
                                                                      i++)
                                                                    EquipmentCategoryCard(
                                                                      onTap:
                                                                          () {
                                                                        if (prefs.equipmentCategory !=
                                                                            i) {
                                                                          context
                                                                              .read<EquipmentSharedPrefsCubit>()
                                                                              .writeEquipmentCategory(i);
                                                                          context
                                                                              .read<EquipmentBloc>()
                                                                              .add(LoadListEquipment(categoryId: listCategory[i].id));
                                                                        }
                                                                      },
                                                                      isSelected:
                                                                          prefs.equipmentCategory ==
                                                                              i,
                                                                      name: listCategory[
                                                                              i]
                                                                          .name,
                                                                    ),
                                                                  const SizedBox(
                                                                      width:
                                                                          11),
                                                                ]),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                        ),
                                  const SizedBox(height: 10),
                                  isSearchOpen
                                      ? BlocBuilder<SearchEquipmentCubit,
                                          SearchEquipmentState>(
                                          builder: (context, state) {
                                            final searchEquipmentState = state;

                                            if (searchEquipmentState
                                                .searchResult.isEmpty) {
                                              return const Expanded(
                                                  child: Center(
                                                      child: Text(
                                                          'Tidak ada data')));
                                            }

                                            return Expanded(
                                              child: selectedView == 0
                                                  ?
                                                  // Listview
                                                  ListView.builder(
                                                      itemCount:
                                                          searchEquipmentState
                                                              .searchResult
                                                              .length,
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.only(
                                                          left: 16,
                                                          right: 16,
                                                          bottom: addRentalState
                                                                      .selectedEquipment
                                                                      .isNotEmpty ||
                                                                  addRentalState
                                                                      .selectedPackage
                                                                      .isNotEmpty
                                                              ? 70
                                                              : 16),
                                                      itemBuilder:
                                                          (context, index) {
                                                        int currentItemCount = addRentalState
                                                            .selectedEquipment
                                                            .where((equipment) =>
                                                                equipment ==
                                                                searchEquipmentState
                                                                        .searchResult[
                                                                    index])
                                                            .length;
                                                        return ChooseEquipmentListCard(
                                                          title:
                                                              searchEquipmentState
                                                                  .searchResult[
                                                                      index]
                                                                  .name,
                                                          price:
                                                              searchEquipmentState
                                                                  .searchResult[
                                                                      index]
                                                                  .price,
                                                          qty: currentItemCount,
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    AddRentalCubit>()
                                                                .addEquipment(
                                                                    searchEquipmentState
                                                                            .searchResult[
                                                                        index]);
                                                          },
                                                          onLongPress: () {
                                                            if (currentItemCount !=
                                                                0) {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  title: Text(
                                                                      'Hapus pilihan ${searchEquipmentState.searchResult[index].name}'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'Tidak'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        context
                                                                            .read<AddRentalCubit>()
                                                                            .addEquipment(searchEquipmentState.searchResult[index]);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'Ya'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        );
                                                      },
                                                    )
                                                  :
                                                  // Gridview
                                                  ListView(
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 16,
                                                        right: 16,
                                                        bottom: 16,
                                                      ),
                                                      children: [
                                                        LayoutGrid(
                                                          columnSizes: [
                                                            1.fr,
                                                            1.fr,
                                                            1.fr
                                                          ],
                                                          rowSizes: List.generate(
                                                              searchEquipmentState
                                                                          .searchResult
                                                                          .length ~/
                                                                      3 +
                                                                  1,
                                                              (index) => auto),
                                                          rowGap: 10,
                                                          columnGap: 10,
                                                          children:
                                                              List.generate(
                                                            searchEquipmentState
                                                                .searchResult
                                                                .length,
                                                            (index) {
                                                              int currentItemCount = addRentalState
                                                                  .selectedEquipment
                                                                  .where((equipment) =>
                                                                      equipment ==
                                                                      searchEquipmentState
                                                                              .searchResult[
                                                                          index])
                                                                  .length;
                                                              return EquipmentGridCard(
                                                                name: searchEquipmentState
                                                                    .searchResult[
                                                                        index]
                                                                    .name,
                                                                price: searchEquipmentState
                                                                    .searchResult[
                                                                        index]
                                                                    .price,
                                                                stockQty: searchEquipmentState
                                                                    .searchResult[
                                                                        index]
                                                                    .stockQty,
                                                                qty:
                                                                    currentItemCount,
                                                                onTap: () {
                                                                  context
                                                                      .read<
                                                                          AddRentalCubit>()
                                                                      .addEquipment(
                                                                          searchEquipmentState
                                                                              .searchResult[index]);
                                                                },
                                                                onLongPress:
                                                                    () {
                                                                  if (currentItemCount !=
                                                                      0) {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                        title: Text(
                                                                            'Hapus pilihan ${searchEquipmentState.searchResult[index].name}'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text('Tidak'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              context.read<AddRentalCubit>().removeAllSelectedEquipment(searchEquipmentState.searchResult[index]);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text('Ya'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            );
                                          },
                                        )
                                      : BlocBuilder<EquipmentBloc,
                                          EquipmentState>(
                                          builder: (context, state) {
                                            if (state is EquipmentError) {
                                              return Expanded(
                                                  child: Center(
                                                      child:
                                                          Text(state.message)));
                                            }

                                            if (state is ListEquipmentLoaded) {
                                              final List<Equipment>
                                                  listEquipment =
                                                  state.listEquipment;

                                              if (listEquipment.isEmpty) {
                                                return const Expanded(
                                                    child: Center(
                                                        child: Text(
                                                            'Tidak ada data')));
                                              }

                                              return Expanded(
                                                child: selectedView == 0
                                                    ?
                                                    // Listview
                                                    ListView.builder(
                                                        itemCount: listEquipment
                                                            .length,
                                                        shrinkWrap: true,
                                                        padding: EdgeInsets.only(
                                                            left: 16,
                                                            right: 16,
                                                            bottom: addRentalState
                                                                        .selectedEquipment
                                                                        .isNotEmpty ||
                                                                    addRentalState
                                                                        .selectedPackage
                                                                        .isNotEmpty
                                                                ? 70
                                                                : 16),
                                                        itemBuilder:
                                                            (context, index) {
                                                          int currentItemCount = addRentalState
                                                              .selectedEquipment
                                                              .where((equipment) =>
                                                                  equipment ==
                                                                  listEquipment[
                                                                      index])
                                                              .length;
                                                          return ChooseEquipmentListCard(
                                                            title:
                                                                listEquipment[
                                                                        index]
                                                                    .name,
                                                            price:
                                                                listEquipment[
                                                                        index]
                                                                    .price,
                                                            qty:
                                                                currentItemCount,
                                                            onTap: () {
                                                              context
                                                                  .read<
                                                                      AddRentalCubit>()
                                                                  .addEquipment(
                                                                      listEquipment[
                                                                          index]);
                                                            },
                                                            onLongPress: () {
                                                              if (currentItemCount !=
                                                                  0) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                    title: Text(
                                                                        'Hapus pilihan ${listEquipment[index].name}'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            'Tidak'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          context
                                                                              .read<AddRentalCubit>()
                                                                              .addEquipment(listEquipment[index]);
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            'Ya'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          );
                                                        },
                                                      )
                                                    :
                                                    // Gridview
                                                    ListView(
                                                        shrinkWrap: true,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 16,
                                                          right: 16,
                                                          bottom: 16,
                                                        ),
                                                        children: [
                                                          LayoutGrid(
                                                            columnSizes: [
                                                              1.fr,
                                                              1.fr,
                                                              1.fr
                                                            ],
                                                            rowSizes: List.generate(
                                                                listEquipment
                                                                            .length ~/
                                                                        3 +
                                                                    1,
                                                                (index) =>
                                                                    auto),
                                                            rowGap: 10,
                                                            columnGap: 10,
                                                            children:
                                                                List.generate(
                                                              listEquipment
                                                                  .length,
                                                              (index) {
                                                                int currentItemCount = addRentalState
                                                                    .selectedEquipment
                                                                    .where((equipment) =>
                                                                        equipment ==
                                                                        listEquipment[
                                                                            index])
                                                                    .length;
                                                                return EquipmentGridCard(
                                                                  name: listEquipment[
                                                                          index]
                                                                      .name,
                                                                  price: listEquipment[
                                                                          index]
                                                                      .price,
                                                                  stockQty: listEquipment[
                                                                          index]
                                                                      .stockQty,
                                                                  qty:
                                                                      currentItemCount,
                                                                  onTap: () {
                                                                    context
                                                                        .read<
                                                                            AddRentalCubit>()
                                                                        .addEquipment(
                                                                            listEquipment[index]);
                                                                  },
                                                                  onLongPress:
                                                                      () {
                                                                    if (currentItemCount !=
                                                                        0) {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) =>
                                                                                AlertDialog(
                                                                          title:
                                                                              Text('Hapus pilihan ${listEquipment[index].name}'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('Tidak'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                context.read<AddRentalCubit>().removeAllSelectedEquipment(listEquipment[index]);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('Ya'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              );
                                            }

                                            return const Expanded(
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator()));
                                          },
                                        ),
                                ],
                              ),
                              // Package
                              BlocBuilder<PackagesCubit, PackagesState>(
                                builder: (context, state) {
                                  final listPackage = state.listPackage;

                                  if (listPackage.isEmpty) {
                                    return const Center(
                                        child: Text('Tidak ada data'));
                                  }

                                  return ListView.builder(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: addRentalState.selectedEquipment
                                                    .isNotEmpty ||
                                                addRentalState
                                                    .selectedPackage.isNotEmpty
                                            ? 70
                                            : 16),
                                    itemCount: listPackage.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      int currentItemCount = addRentalState
                                          .selectedPackage
                                          .where((package) =>
                                              package == listPackage[index])
                                          .length;

                                      return PackageListCard(
                                        onTap: () {
                                          context
                                              .read<AddRentalCubit>()
                                              .addPackage(listPackage[index]);
                                        },
                                        onLongPress: () {
                                          if (currentItemCount != 0) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                    'Hapus pilihan ${listPackage[index].name}'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Tidak'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              AddRentalCubit>()
                                                          .removeAllSelectedPackage(
                                                              listPackage[
                                                                  index]);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Ya'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        qty: currentItemCount,
                                        package: listPackage[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    addRentalState.selectedEquipment.isNotEmpty ||
                            addRentalState.selectedPackage.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10,
                                ),
                                child: FilledButton(
                                  onPressed: () {
                                    state.gapDay != null
                                        ? null
                                        : context
                                            .read<AddRentalCubit>()
                                            .gapDayChanged(1);
                                    context.read<AddRentalCubit>().totalPrice();
                                    router.pushNamed('confirm_equipment');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          (addRentalState.selectedEquipment
                                                      .length +
                                                  addRentalState
                                                      .selectedPackage.length)
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text('peralatan'),
                                        const Expanded(
                                            child: SizedBox.shrink()),
                                        Text(
                                          'Lanjut',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                        ),
                                        const Icon(Icons.chevron_right_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
