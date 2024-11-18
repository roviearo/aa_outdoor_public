import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/router.dart';
import '../cubit/add_package/add_package_cubit.dart';
import '../cubit/packages/packages_cubit.dart';
import '../widget/selected_equipment_package.dart';

class AddPackageScreen extends StatelessWidget {
  const AddPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController packageNameTextEditingController =
        TextEditingController();
    TextEditingController packagePriceTextEditingController =
        TextEditingController();

    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AddPackageCubit, AddPackageState>(
            listener: (context, state) {
              if (state.status == AddPackageStatus.success) {
                context.read<AddPackageCubit>().clearAddPackage();
                context.read<PackagesCubit>().loadListPackage();
                router.pop();
                router.pop();
              }

              if (state.status == AddPackageStatus.submitting) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
              }

              if (state.status == AddPackageStatus.error) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButton(),
                            Text(
                              'Tambah Pilihan Paket',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            IconButton(
                              onPressed: () {
                                packageNameTextEditingController.clear();
                                packagePriceTextEditingController.clear();
                                context
                                    .read<AddPackageCubit>()
                                    .clearAddPackage();
                              },
                              icon: SvgPicture.asset(
                                'icons/reset.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Nama Paket',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: packageNameTextEditingController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                          ),
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) => context
                              .read<AddPackageCubit>()
                              .nameChanged(value),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Total Harga',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: packagePriceTextEditingController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              context
                                  .read<AddPackageCubit>()
                                  .priceChanged(int.parse(value));
                            }
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Divider(thickness: 10, height: 0),
                      const SizedBox(height: 15),
                      state.selectedEquipment.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.groupingEquipment
                                    .equipmentQuantity(
                                        state.groupingEquipment.listEquipment)
                                    .keys
                                    .length,
                                itemBuilder: (context, index) {
                                  var equipment = state.groupingEquipment
                                      .equipmentQuantity(
                                          state.groupingEquipment.listEquipment)
                                      .keys
                                      .elementAt(index);

                                  var equipmentQty = state.groupingEquipment
                                      .equipmentQuantity(
                                          state.groupingEquipment.listEquipment)
                                      .entries
                                      .elementAt(index)
                                      .value;

                                  return SelectedEquipmentPackage(
                                    equipment: equipment,
                                    qty: equipmentQty.toString(),
                                    onRemoveTap: () => context
                                        .read<AddPackageCubit>()
                                        .removeEquipment(equipment),
                                  );
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                      state.selectedEquipment.isNotEmpty
                          ? Center(
                              child: Text(
                                'Total harga kasar: Rp ${Constants.formatPrice.format(state.grossPrice)}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, bottom: 70),
                        child: FilledButton(
                          onPressed: () {
                            router.pushNamed('choose_equipment_package');
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '+',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      // const SizedBox(height: 70),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: FilledButton(
                          onPressed: () =>
                              context.read<AddPackageCubit>().addPackage(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tambahkan Paket',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
