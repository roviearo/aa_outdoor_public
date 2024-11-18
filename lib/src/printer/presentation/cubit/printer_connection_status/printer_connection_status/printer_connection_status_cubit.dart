import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../../domain/usecases/connect_to_printer.dart';
import '../../../../domain/usecases/save_bluetooth_mac_address.dart';

part 'printer_connection_status_state.dart';
part 'printer_connection_status_cubit.freezed.dart';

enum PrinterStatus { initial, connected, disconnected, connecting, error }

class PrinterConnectionStatusCubit extends Cubit<PrinterConnectionStatusState> {
  PrinterConnectionStatusCubit({
    required ConnectToPrinter connectToPrinter,
    required SaveBluetoothMacAddress saveBluetoothMacAddress,
  })  : _connectToPrinter = connectToPrinter,
        _saveBluetoothMacAddress = saveBluetoothMacAddress,
        super(const PrinterConnectionStatusState.initial());

  Timer? timer;
  final ConnectToPrinter _connectToPrinter;
  final SaveBluetoothMacAddress _saveBluetoothMacAddress;

  void startMonitoring() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      bool isConnected = await PrintBluetoothThermal.connectionStatus;
      isConnected
          ? emit(state.copyWith(
              status: PrinterStatus.connected,
              message: 'Printer Connected',
            ))
          : emit(state.copyWith(
              status: PrinterStatus.disconnected,
              message: 'Printer Disconnected'));
    });
  }

  void connectToPrinter(String macAddress) async {
    emit(state.copyWith(status: PrinterStatus.connecting));

    await _saveBluetoothMacAddress
        .call(SaveBluetoothMacAddressParams(value: macAddress));

    final result = await _connectToPrinter
        .call(ConnectToPrinterParams(macAddress: macAddress));

    result.fold(
      (failure) => emit(state.copyWith(
        status: PrinterStatus.disconnected,
        message: 'Konek ke printer gagal',
      )),
      (isConnected) => startMonitoring(),
    );
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
