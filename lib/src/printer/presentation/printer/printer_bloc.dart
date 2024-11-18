import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../rental/domain/entities/rental.dart';
import '../../domain/usecases.dart';
import '../../domain/usecases/print_bill.dart';
import '../../domain/usecases/print_list_equipment.dart';

part 'printer_event.dart';
part 'printer_state.dart';
part 'printer_bloc.freezed.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBloc({
    required GetBondedDevices getBondedDevices,
    required IsBluetoothEnabled isBluetoothEnabled,
    required OpenBluetoothSetting openBluetoothSetting,
    required PrintBill printBill,
    required PrintListEquipment printListEquipment,
  })  : _getBondedDevices = getBondedDevices,
        _isBluetoothEnabled = isBluetoothEnabled,
        _openBluetoothSetting = openBluetoothSetting,
        _printBill = printBill,
        _printListEquipment = printListEquipment,
        super(const Initial()) {
    on<CheckBluetoothIsEnabled>(_onCheckBluetoothIsEnabled);
    on<OpenBluetoothSettingEvent>(_onOpenBluetoothSettingEvent);
    on<LoadBondedDevice>(_onLoadBondedDevice);
    on<PrintBillEvent>(_onPrintBillEvent);
    on<PrintListEquipmentEvent>(_onPrintListEquipmentEvent);
  }

  final GetBondedDevices _getBondedDevices;
  final IsBluetoothEnabled _isBluetoothEnabled;
  final OpenBluetoothSetting _openBluetoothSetting;
  final PrintBill _printBill;
  final PrintListEquipment _printListEquipment;

  _onCheckBluetoothIsEnabled(
    CheckBluetoothIsEnabled event,
    Emitter<PrinterState> emit,
  ) async {
    emit(const PrinterLoading());

    final result = await _isBluetoothEnabled.call();

    result.fold(
      (failure) => emit(PrinterError(failure.message)),
      (isEnabled) => emit(BluetoothChecked(isEnabled)),
    );
  }

  _onOpenBluetoothSettingEvent(
    OpenBluetoothSettingEvent event,
    Emitter<PrinterState> emit,
  ) {
    _openBluetoothSetting.call();
  }

  _onLoadBondedDevice(
    LoadBondedDevice event,
    Emitter<PrinterState> emit,
  ) async {
    emit(const PrinterLoading());

    final result = await _getBondedDevices.call();

    result.fold(
      (failure) => emit(PrinterError(failure.message)),
      (devices) => emit(BondedDeviceLoaded(devices)),
    );
  }

  _onPrintBillEvent(PrintBillEvent event, Emitter<PrinterState> emit) async {
    final result = await _printBill.call(PrintBillParams(
        rental: event.rental, payment: event.payment, change: event.change));

    result.fold(
      (failure) => emit(PrinterError(failure.message)),
      (isPrinted) => emit(PrintSucceeded(isPrinted)),
    );
  }

  _onPrintListEquipmentEvent(
      PrintListEquipmentEvent event, Emitter<PrinterState> emit) async {
    final result = await _printListEquipment
        .call(PrintListEquipmentParams(rental: event.rental));

    result.fold(
      (failure) => emit(PrinterError(failure.message)),
      (isPrinted) => emit(PrintSucceeded(isPrinted)),
    );
  }
}
