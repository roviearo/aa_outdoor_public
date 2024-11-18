import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/router.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../printer/presentation/printer/printer_bloc.dart';
import '../cubit/detail_rental/detail_rental_cubit.dart';
import '../cubit/rentals/rentals_cubit.dart';
import '../widget/card_detail_rental.dart';
import '../widget/list_detail_rental.dart';
import '../widget/rented_equipment.dart';

class DetailRentalScreen extends StatelessWidget {
  const DetailRentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrinterBloc, PrinterState>(
      listener: (context, state) {
        if (state is PrintSucceeded) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.isPrinted
                  ? 'Print nota berhasil'
                  : 'Print nota gagal')));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<RentalsCubit, RentalsState>(
            listener: (context, state) {
              if (state.status == RentalsStatus.error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }

              if (state.status == RentalsStatus.success) {
                context.read<HomeCubit>().loadHomeCubit(Constants.rentalUndone);
                context.read<RentalsCubit>().loadUnfinishedRental();
                router.goNamed('main');
              }
            },
            child: BlocBuilder<DetailRentalCubit, DetailRentalState>(
              builder: (context, state) {
                final rental = state.rental;

                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BackButton(),
                          Text(
                            'Detail Rental',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 20,
                                        right: 20,
                                        bottom: 5,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Yakin hapus judul?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .05),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {},
                                                child: const Text('Ya'),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('Tidak'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: SvgPicture.asset(
                              'icons/trash.svg',
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardDetailRental(
                            assetName: 'preview_bill.svg',
                            title: 'Preview Pesanan',
                            onTap: () {
                              router.pushNamed('preview_detail_rental');
                            },
                          ),
                          CardDetailRental(
                            assetName: 'print_list_eq.svg',
                            title: 'Print Daftar Pesanan',
                            onTap: () => context
                                .read<PrinterBloc>()
                                .add(PrinterEvent.printListEquipment(rental)),
                          ),
                          CardDetailRental(
                            assetName: 'print_bill_dual.svg',
                            title: 'Print Nota',
                            onTap: () => context.read<PrinterBloc>().add(
                                PrinterEvent.printBill(rental, null, null)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(thickness: 10, height: 0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListDetailRental(
                                  title: 'Nama', value: rental.name),
                              ListDetailRental(
                                  title: 'Alamat', value: rental.address ?? ''),
                              ListDetailRental(
                                  title: 'Nomor Telepon',
                                  value: rental.phoneNumber ?? ''),
                              ListDetailRental(
                                  title: 'Nama di Kartu Identitas',
                                  value: rental.nameIdCard ?? ''),
                              ListDetailRental(
                                  title: 'Jenis Kartu Identitas',
                                  value: rental.idCardType),
                              ListDetailRental(
                                  title: 'Tanggal Sewa',
                                  value: Constants.dateFormat
                                      .format(rental.startDate)),
                              ListDetailRental(
                                  title: 'Tanggal Kembali',
                                  value: Constants.dateFormat
                                      .format(rental.endDate)),
                              ListDetailRental(
                                  title: 'Status', value: rental.status),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Harga',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                  Text(
                                    'Rp ${Constants.formatPrice.format(rental.totalPrice)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ExpandableNotifier(
                                child: ScrollOnExpand(
                                  child: ExpandablePanel(
                                    collapsed: Column(
                                      children: [
                                        ExpandableButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Lihat peralatan',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              const Icon(Icons
                                                  .keyboard_arrow_down_rounded),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    expanded: Column(
                                      children: [
                                        ExpandableButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Lihat peralatan',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              const Icon(Icons
                                                  .keyboard_arrow_up_rounded),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: rental.listPackage?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              RentedEquipment(
                                            name:
                                                rental.listPackage![index].name,
                                            qty: rental
                                                .listPackage![index].packageQty,
                                            price: rental.listPackage![index]
                                                .pricePackage,
                                          ),
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              rental.listEquipment?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              RentedEquipment(
                                            name: rental
                                                .listEquipment![index].name,
                                            qty: rental.listEquipment![index]
                                                .qtyRental,
                                            price: rental.listEquipment![index]
                                                .priceRental,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              rental.status != Constants.rentalDone
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: FilledButton(
                                            onPressed: () {
                                              context
                                                  .read<RentalsCubit>()
                                                  .returnRental(rental.id);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Text(
                                                Constants.rentalDone,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                    ),
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
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
