import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/router.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../printer/presentation/cubit/bluetooth_status/bluetooth_status_cubit.dart';
import '../../../printer/presentation/cubit/printer_connection_status/printer_connection_status/printer_connection_status_cubit.dart';
import '../../../printer/presentation/printer/printer_bloc.dart';
import '../cubit/add_rental/add_rental_cubit.dart';
import '../cubit/detail_rental/detail_rental_cubit.dart';
import '../cubit/rentals/rentals_cubit.dart';

class TransactionSuccessfulScreen extends StatelessWidget {
  const TransactionSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool printed = false;

    return BlocListener<PrinterBloc, PrinterState>(
      listener: (context, state) {
        if (state is PrintSucceeded) {
          state.isPrinted ? printed = true : printed = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.isPrinted
                  ? 'Print nota berhasil'
                  : 'Print nota gagal')));
        }
      },
      child: PopScope(
        canPop: printed,
        onPopInvokedWithResult: (didPop, result) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                    'Nota belum diprint, apakah anda yakin akan keluar?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      router.pop();
                    },
                    child: const Text('Tidak'),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<HomeCubit>()
                          .loadHomeCubit(Constants.rentalUndone);
                      context.read<RentalsCubit>().loadUnfinishedRental();
                      router.goNamed('main');
                    },
                    child: const Text('Ya'),
                  ),
                ],
              );
            },
          );
        },
        child: Scaffold(
          body: BlocBuilder<AddRentalCubit, AddRentalState>(
            builder: (context, state) {
              final addRentalState = state;
              return SafeArea(
                child: Column(
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    SvgPicture.asset(
                      'icons/done.svg',
                      width: MediaQuery.of(context).size.width * .5,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Transaksi Berhasil',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Kembalian',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    'Rp ${Constants.formatPrice.format(state.returnNominal)}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                router.pushNamed('preview_detail_rental');
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Preview Pesanan',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const Expanded(child: SizedBox.shrink()),
                                    SvgPicture.asset(
                                      'icons/chevron_right.svg',
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<DetailRentalCubit, DetailRentalState>(
                              builder: (context, state) {
                                final detailRentalState = state;
                                return BlocBuilder<PrinterConnectionStatusCubit,
                                    PrinterConnectionStatusState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        if (state.status ==
                                            PrinterStatus.connected) {
                                          context
                                              .read<PrinterBloc>()
                                              .add(PrintBillEvent(
                                                detailRentalState.rental,
                                                addRentalState.paymentNominal,
                                                addRentalState.returnNominal,
                                              ));
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Print Nota',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        color: state.status ==
                                                                PrinterStatus
                                                                    .connected
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .onSecondaryContainer
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .outline,
                                                      ),
                                                ),
                                                const Expanded(
                                                    child: SizedBox.shrink()),
                                                SvgPicture.asset(
                                                  'icons/chevron_right.svg',
                                                  colorFilter: ColorFilter.mode(
                                                    state.status ==
                                                            PrinterStatus
                                                                .connected
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onSecondaryContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .outline,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            state.status ==
                                                    PrinterStatus.connected
                                                ? const SizedBox.shrink()
                                                : GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              BluetoothStatusCubit>()
                                                          .startCheckBluetooth();
                                                      router.pushNamed(
                                                          'printer_setting');
                                                    },
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    child: Container(
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .error,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          )),
                                                      child: Center(
                                                        child: Text(
                                                          'Printer offline, buka pengaturan Printer',
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onError,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: FilledButton(
                        onPressed: () {
                          if (printed) {
                            context
                                .read<HomeCubit>()
                                .loadHomeCubit(Constants.rentalUndone);
                            context.read<RentalsCubit>().loadUnfinishedRental();
                            router.goNamed('main');
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Nota belum diprint, apakah anda yakin akan keluar?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        router.pop();
                                      },
                                      child: const Text('Tidak'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<HomeCubit>().loadHomeCubit(
                                            Constants.rentalUndone);
                                        context
                                            .read<RentalsCubit>()
                                            .loadUnfinishedRental();
                                        router.goNamed('main');
                                      },
                                      child: const Text('Ya'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text('Selesai'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
