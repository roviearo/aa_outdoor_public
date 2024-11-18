import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/router.dart';
import '../../../../core/widgets/no_data.dart';
import '../cubit/edit_package/edit_package_cubit.dart';
import '../cubit/packages/packages_cubit.dart';
import '../widget/package_card.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PackagesCubit, PackagesState>(
      listener: (context, state) {
        if (state.status == PackagesStatus.deleting) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.status == PackagesStatus.deleted) {
          router.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButton(),
                        Text(
                          'Pilihan Paket',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<PackagesCubit, PackagesState>(
                    builder: (context, state) {
                      final listPackage = state.listPackage;

                      if (listPackage.isEmpty) {
                        return const NoData();
                      }

                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 70),
                          itemCount: listPackage.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => PackageCard(
                            package: listPackage[index],
                            onEditTap: () {
                              context
                                  .read<EditPackageCubit>()
                                  .idChanged(listPackage[index].id);
                              context
                                  .read<EditPackageCubit>()
                                  .nameChanged(listPackage[index].name);
                              context
                                  .read<EditPackageCubit>()
                                  .priceChanged(listPackage[index].totalPrice);

                              context
                                  .read<EditPackageCubit>()
                                  .initialGroupingEquipment(
                                      listPackage[index].listEquipment);
                              router.pushNamed('edit_package');
                            },
                            onDeleteTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Yakin hapus ${listPackage[index].name} ?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .075,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(child: SizedBox()),
                                            TextButton(
                                              onPressed: () {
                                                router.pop();
                                              },
                                              child: const Text('Tidak'),
                                            ),
                                            const SizedBox(width: 10),
                                            TextButton(
                                              onPressed: () {
                                                context
                                                    .read<PackagesCubit>()
                                                    .deletePackage(
                                                        listPackage[index].id);
                                                router.pop();
                                              },
                                              child: const Text('Ya'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16,
                    ),
                    child: FilledButton(
                      onPressed: () {
                        router.pushNamed('add_package');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tambah Pilihan Paket',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
