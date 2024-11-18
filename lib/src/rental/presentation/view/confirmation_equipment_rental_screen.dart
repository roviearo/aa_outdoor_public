// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/router.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../../../package/domain/entities/package.dart';
import '../cubit/add_rental/add_rental_cubit.dart';
import '../widget/change_qty_dialog.dart';
import '../widget/equipment_confirm_card.dart';
import '../widget/package_change_qty_dialog.dart';

class ConfirmationEquipmentScreen extends StatefulWidget {
  const ConfirmationEquipmentScreen({super.key});

  @override
  State<ConfirmationEquipmentScreen> createState() =>
      _ConfirmationEquipmentScreenState();
}

class _ConfirmationEquipmentScreenState
    extends State<ConfirmationEquipmentScreen> {
  late int gapDay;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    gapDay = 1;
    startDate = DateTime.now();
    endDate = DateTime.now().add(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddRentalCubit, AddRentalState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButton(),
                            Text(
                              'Rp ${Constants.formatPrice.format(state.totalPrice)}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (state.gapDay ?? gapDay).toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Hari',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      state.selectedEquipment.isNotEmpty &&
                              state.selectedPackage.isNotEmpty
                          ? Text(
                              'Paket',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : const SizedBox.shrink(),
                      state.selectedPackage.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.groupingPackage
                                  ?.packageQuantity(
                                      state.groupingPackage?.listPackage)
                                  .keys
                                  .length,
                              itemBuilder: (context, index) {
                                var package = state.groupingPackage
                                    ?.packageQuantity(
                                        state.groupingPackage?.listPackage)
                                    .keys
                                    .elementAt(index);

                                var packageQty = state.groupingPackage
                                    ?.packageQuantity(
                                        state.groupingPackage?.listPackage)
                                    .entries
                                    .elementAt(index)
                                    .value;

                                return EquipmentConfirmCard(
                                  number: index + 1,
                                  title: package.name,
                                  qty: packageQty,
                                  price: package.totalPrice,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          PackageChangeQtyDialog(
                                        package: package,
                                        listPackage: state.selectedPackage,
                                      ),
                                    );
                                  },
                                  onDeleteTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Hapus ${package.name}'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Tidak'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              List<Package> selectedPackage =
                                                  [];
                                              selectedPackage.addAll(
                                                  state.selectedPackage);

                                              selectedPackage.removeWhere(
                                                  (package1) =>
                                                      package1 == package);

                                              context
                                                  .read<AddRentalCubit>()
                                                  .selectedPackageChanged(
                                                      selectedPackage);

                                              context
                                                  .read<AddRentalCubit>()
                                                  .totalPrice();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ya'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                      SizedBox(
                          height: state.selectedPackage.isNotEmpty ? 10 : 0),
                      state.selectedEquipment.isNotEmpty &&
                              state.selectedPackage.isNotEmpty
                          ? Text(
                              'Peralatan',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : const SizedBox.shrink(),
                      state.selectedEquipment.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 110),
                              shrinkWrap: true,
                              itemCount: state.groupingEquipment
                                  ?.equipmentQuantity(
                                      state.groupingEquipment?.listEquipment)
                                  .keys
                                  .length,
                              itemBuilder: (context, index) {
                                var equipment = state.groupingEquipment
                                    ?.equipmentQuantity(
                                        state.groupingEquipment?.listEquipment)
                                    .keys
                                    .elementAt(index);

                                var equipmentQty = state.groupingEquipment
                                    ?.equipmentQuantity(
                                        state.groupingEquipment?.listEquipment)
                                    .entries
                                    .elementAt(index)
                                    .value;

                                return EquipmentConfirmCard(
                                  number: index + 1,
                                  title: equipment.name,
                                  qty: equipmentQty,
                                  price: equipment.price,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ChangeQtyDialog(
                                        equipment: equipment,
                                        listEquipment: state.selectedEquipment,
                                      ),
                                    );
                                  },
                                  onDeleteTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Hapus ${equipment.name}'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Tidak'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              List<Equipment>
                                                  selectedEquipment = [];
                                              selectedEquipment.addAll(
                                                  state.selectedEquipment);

                                              selectedEquipment.removeWhere(
                                                  (equipment1) =>
                                                      equipment1 == equipment);

                                              context
                                                  .read<AddRentalCubit>()
                                                  .selectedEquipmentChanged(
                                                      selectedEquipment);

                                              context
                                                  .read<AddRentalCubit>()
                                                  .totalPrice();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ya'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: Text(
                          '${Constants.dateFormat.format(state.startDate ?? startDate)} - ${Constants.dateFormat.format(state.endDate ?? endDate)}',
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  router.pushNamed('detail_consumer');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            FilledButton(
                              onPressed: () async {
                                final selectedDate = await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  initialDateRange: DateTimeRange(
                                    start: startDate,
                                    end: endDate,
                                  ),
                                );

                                if (selectedDate != null) {
                                  setState(() {
                                    startDate = selectedDate.start;
                                    endDate = selectedDate.end;
                                    gapDay = selectedDate.end
                                        .difference(selectedDate.start)
                                        .inDays;
                                  });
                                  context
                                      .read<AddRentalCubit>()
                                      .startDateChanged(selectedDate.start);
                                  context
                                      .read<AddRentalCubit>()
                                      .endDateChanged(selectedDate.end);
                                  context
                                      .read<AddRentalCubit>()
                                      .gapDayChanged(gapDay);
                                }
                              },
                              style: ButtonStyle(
                                padding: const WidgetStatePropertyAll(
                                    EdgeInsets.all(0)),
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.surface,
                                ),
                                overlayColor: WidgetStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'icons/calendar.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
