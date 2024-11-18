import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

part 'bluetooth_status_state.dart';
part 'bluetooth_status_cubit.freezed.dart';

enum BluetoothStatus { initial, enabled, disabled }

class BluetoothStatusCubit extends Cubit<BluetoothStatusState> {
  BluetoothStatusCubit() : super(const BluetoothStatusState.initial());

  Timer? timer;

  void startCheckBluetooth() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      bool isEnabled = await PrintBluetoothThermal.bluetoothEnabled;
      isEnabled
          ? emit(state.copyWith(
              bluetoothStatus: BluetoothStatus.enabled,
              message: 'Bluetooth Enabled'))
          : emit(state.copyWith(
              bluetoothStatus: BluetoothStatus.disabled,
              message: 'Bluetooth Disabled'));
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
