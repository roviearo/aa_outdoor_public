import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/router.dart';
import '../cubit/add_rental/add_rental_cubit.dart';
import '../cubit/detail_rental/detail_rental_cubit.dart';

class PaymentRentalScreen extends StatefulWidget {
  const PaymentRentalScreen({super.key});

  @override
  State<PaymentRentalScreen> createState() => _PaymentRentalScreenState();
}

class _PaymentRentalScreenState extends State<PaymentRentalScreen>
    with SingleTickerProviderStateMixin {
  String nominal = '0';
  late TabController _tabController;

  int _selectedIndex = 1;

  static NumberFormat formatNominal = NumberFormat("#,###", "id_ID");

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(
      () {
        setState(() {
          _selectedIndex = _tabController.index;
        });
        switch (_selectedIndex) {
          case 0:
            context
                .read<AddRentalCubit>()
                .paymentTypeChanged(PaymentType.transfer);
            break;
          case 1:
            context.read<AddRentalCubit>().paymentTypeChanged(PaymentType.cash);
            break;
          case 2:
            context.read<AddRentalCubit>().paymentTypeChanged(PaymentType.qris);
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddRentalCubit, AddRentalState>(
        listener: (context, state) {
          if (state.addRentalStatus == AddRentalStatus.submitting) {
            showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          }

          if (state.addRentalStatus == AddRentalStatus.error) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state.addRentalStatus == AddRentalStatus.success) {
            Navigator.pop(context);
            context
                .read<DetailRentalCubit>()
                .getDetailRental(state.newRentalId);
            router.goNamed('transaction_success');
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                _tabController.index == 1
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * .17,
                        child: Center(
                          child: Text(
                            'Rp ${formatNominal.format(int.parse(nominal))}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * .17,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: [
                                  SvgPicture.asset(
                                    'icons/camera.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Tambah Foto Bukti Transfer',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TabBar(
                            dividerHeight: 0,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            indicator: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            splashBorderRadius: BorderRadius.circular(10),
                            labelColor: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            unselectedLabelColor:
                                Theme.of(context).colorScheme.outline,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'icons/transfer.svg',
                                      colorFilter: ColorFilter.mode(
                                        _selectedIndex != 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .outline
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('Transfer'),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'icons/cash.svg',
                                      colorFilter: ColorFilter.mode(
                                        _selectedIndex != 1
                                            ? Theme.of(context)
                                                .colorScheme
                                                .outline
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('Tunai'),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'icons/qr.svg',
                                      colorFilter: ColorFilter.mode(
                                        _selectedIndex != 2
                                            ? Theme.of(context)
                                                .colorScheme
                                                .outline
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('QRIS'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Transfer
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CIMB NIAGA\na/n AKHMAD ROVIANSYAH',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '234345786',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),

                            // Cash
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: NumberButton(
                                            value: '7',
                                            onTap: () {
                                              _numberButtonPressed('7');
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 3,
                                          child: NumberButton(
                                            value: '8',
                                            onTap: () {
                                              _numberButtonPressed('8');
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 3,
                                          child: NumberButton(
                                            value: '9',
                                            onTap: () {
                                              _numberButtonPressed('9');
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          child: NumberButton(
                                            value: 'C',
                                            onTap: () {
                                              setState(() {
                                                nominal = '0';
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: NumberButton(
                                            value: '4',
                                            onTap: () {
                                              _numberButtonPressed('4');
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 3,
                                          child: NumberButton(
                                            value: '5',
                                            onTap: () {
                                              _numberButtonPressed('5');
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 3,
                                          child: NumberButton(
                                            value: '6',
                                            onTap: () {
                                              _numberButtonPressed('6');
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .shadow
                                                      .withAlpha(50),
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondaryContainer,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (nominal != '0' &&
                                                        nominal.isNotEmpty) {
                                                      nominal =
                                                          nominal.substring(
                                                              0,
                                                              nominal.length -
                                                                  1);
                                                    }
                                                    if (nominal.isEmpty) {
                                                      nominal = '0';
                                                    }
                                                  });
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      'icons/backspace.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .onSecondaryContainer,
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Flexible(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 10,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 3,
                                                      child: NumberButton(
                                                        value: '1',
                                                        onTap: () {
                                                          _numberButtonPressed(
                                                              '1');
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Flexible(
                                                      flex: 3,
                                                      child: NumberButton(
                                                        value: '2',
                                                        onTap: () {
                                                          _numberButtonPressed(
                                                              '2');
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Flexible(
                                                      flex: 3,
                                                      child: NumberButton(
                                                        value: '3',
                                                        onTap: () {
                                                          _numberButtonPressed(
                                                              '3');
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        child: Center(
                                                      child: Image.asset(
                                                        'images/logo_polos_aa.png',
                                                        width: 45,
                                                      ),
                                                    )),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: NumberButton(
                                                        value: '0',
                                                        onTap: () {
                                                          _numberButtonPressed(
                                                              '0');
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: NumberButton(
                                                        value: '000',
                                                        onTap: () {
                                                          if (nominal != '0' &&
                                                              nominal.length <
                                                                  8) {
                                                            _numberButtonPressed(
                                                                '000');
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .shadow
                                                      .withAlpha(100),
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: InkWell(
                                                onTap: () async {
                                                  if (int.parse(nominal) <
                                                      state.totalPrice) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Nominal kosong atau kurang dari jumlah yang harus dibayarkan')));
                                                  } else {
                                                    context
                                                        .read<AddRentalCubit>()
                                                        .paymentNominalChanged(
                                                            int.parse(nominal));
                                                    context
                                                        .read<AddRentalCubit>()
                                                        .addRental();
                                                  }
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      'icons/check_square.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Qris
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                    ),
                                    child: QrImageView(
                                      data: '1234567890',
                                      version: QrVersions.auto,
                                      size: MediaQuery.of(context).size.width *
                                          .7,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _numberButtonPressed(String value) {
    setState(() {
      if (nominal == '0') {
        nominal = value;
      } else if (nominal.length < 10) {
        nominal = nominal + value;
      }
    });
  }
}

class NumberButton extends StatelessWidget {
  const NumberButton({
    super.key,
    required this.value,
    required this.onTap,
  });

  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(50),
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Material(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                value,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
