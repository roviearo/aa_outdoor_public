part of 'bluetooth_status_cubit.dart';

@freezed
class BluetoothStatusState with _$BluetoothStatusState {
  const factory BluetoothStatusState.initial({
    @Default(BluetoothStatus.initial) BluetoothStatus bluetoothStatus,
    @Default('') String message,
  }) = Initial;
}
