import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../cubit/bluetooth_status/bluetooth_status_cubit.dart';
import '../cubit/printer_connection_status/printer_connection_status/printer_connection_status_cubit.dart';
import '../printer/printer_bloc.dart';

class PrinterSettingScreen extends StatefulWidget {
  const PrinterSettingScreen({super.key});

  @override
  State<PrinterSettingScreen> createState() => _PrinterSettingScreenState();
}

class _PrinterSettingScreenState extends State<PrinterSettingScreen> {
  BluetoothInfo? selectedDevice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  Text(
                    'Pengaturan Printer',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const SizedBox(height: 10),
            BlocConsumer<BluetoothStatusCubit, BluetoothStatusState>(
              listener: (context, state) {
                if (state.bluetoothStatus == BluetoothStatus.enabled) {
                  context.read<PrinterBloc>().add(const LoadBondedDevice());
                }
              },
              builder: (context, state) {
                if (state.bluetoothStatus == BluetoothStatus.initial) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
                if (state.bluetoothStatus == BluetoothStatus.enabled) {
                  return BlocBuilder<PrinterBloc, PrinterState>(
                    builder: (context, state) {
                      if (state is BondedDeviceLoaded) {
                        final devices = state.devices;

                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            BlocBuilder<PrinterConnectionStatusCubit,
                                PrinterConnectionStatusState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    SvgPicture.asset(
                                      'icons/printer.svg',
                                      colorFilter: ColorFilter.mode(
                                          state.status ==
                                                  PrinterStatus.connected
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                          BlendMode.srcIn),
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                    ),
                                    const SizedBox(height: 20),
                                    state.status == PrinterStatus.connected
                                        ? Text(
                                            'ONLINE',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                          )
                                        : Text(
                                            'OFFLINE',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .outline,
                                                ),
                                          ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            DropdownButton<BluetoothInfo>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              itemHeight: 50,
                              isExpanded: true,
                              value: selectedDevice,
                              hint: const Text('Pilih Printer'),
                              items: devices
                                  .map((device) => DropdownMenuItem(
                                        value: device,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(device.name),
                                              Text(
                                                'MAC Address: ${device.macAdress}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      fontSize: 10,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDevice = value;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10,
                              ),
                              child: FilledButton(
                                onPressed: selectedDevice != null
                                    ? () => context
                                        .read<PrinterConnectionStatusCubit>()
                                        .connectToPrinter(
                                            selectedDevice!.macAdress)
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Hubungkan',
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
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                } else {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'icons/bluetooth.svg',
                          width: MediaQuery.of(context).size.width * .5,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.outline,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('Bluetooth mati'),
                        const SizedBox(height: 10),
                        FilledButton(
                          onPressed: () {
                            context
                                .read<PrinterBloc>()
                                .add(const OpenBluetoothSettingEvent());
                          },
                          child: const Text('Buka pengaturan'),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
