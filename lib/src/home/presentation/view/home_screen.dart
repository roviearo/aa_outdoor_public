import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../package/presentation/cubit/edit_package/edit_package_cubit.dart';
import '../../../package/presentation/cubit/packages/packages_cubit.dart';
import '../../../rental/presentation/cubit/add_rental/add_rental_cubit.dart';
import '../cubit/home_cubit.dart';
import '../widget/package_expandable_home.dart';
import '/core/utils/router.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/rental_card.dart';
import '../../../equipment/presentation/blocs/category/category_bloc.dart';
import '/src/home/presentation/widget/home_category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(useLogo: true),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => router.pushNamed('search'),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).disabledColor,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'icons/search.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).disabledColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Cari pelanggan atau peralatan',
                        style: TextStyle(
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kategori',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        context
                            .read<CategoryBloc>()
                            .add(const LoadListCategory());
                        router.pushNamed('category');
                      },
                      child: Text(
                        'Lihat semua',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Theme.of(context).disabledColor,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ListCategoryLoaded) {
                    final listCategory = state.listCategory;

                    if (listCategory.isEmpty) {
                      return const Center(child: Text('Tidak ada data'));
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          for (int i = 0; i < 4; i++)
                            HomeCategoryCard(
                              name: listCategory[i].name,
                            ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: Text('Error'));
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rental',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Belum Selesai',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                        ),
                        SvgPicture.asset(
                          'icons/sort_newest.svg',
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).disabledColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.status == HomeStatus.error) {
                    return const Center(child: Text('Error'));
                  }

                  if (state.status == HomeStatus.loaded) {
                    final listRental = state.listRental;

                    if (listRental.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada data'),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: listRental.length,
                      itemBuilder: (context, index) {
                        int endDate =
                            listRental[index].endDate.millisecondsSinceEpoch;
                        return RentalCard(
                            rental: listRental[index],
                            color: DateTime.now()
                                        .subtract(const Duration(days: 1))
                                        .millisecondsSinceEpoch >
                                    endDate
                                ? Theme.of(context).colorScheme.errorContainer
                                : null);
                      },
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        router.pushNamed('rental');
                      },
                      child: const Text('Lihat semua'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pilihan Paket',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              BlocBuilder<PackagesCubit, PackagesState>(
                builder: (context, state) {
                  final listPackage = state.listPackage;

                  if (listPackage.isEmpty) {
                    return const Center(child: Text('Tidak ada data'));
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listPackage.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => PackageExpandableHome(
                      package: listPackage[index],
                      onTap: () {
                        context
                            .read<AddRentalCubit>()
                            .addPackage(listPackage[index]);
                        router.pushNamed('add_rental');
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<EditPackageCubit>().loadListEquipment();
                        context.read<PackagesCubit>().loadListPackage();
                        router.pushNamed('package');
                      },
                      child: const Text('Lihat semua'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
