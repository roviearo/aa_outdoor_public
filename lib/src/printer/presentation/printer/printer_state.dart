part of 'printer_bloc.dart';

@freezed
class PrinterState with _$PrinterState {
  const factory PrinterState.initial() = Initial;
  const factory PrinterState.printerLoading() = PrinterLoading;
  const factory PrinterState.bondedDeviceLoaded(List<BluetoothInfo> devices) =
      BondedDeviceLoaded;
  const factory PrinterState.bluetoothChecked(bool isEnabled) =
      BluetoothChecked;
  const factory PrinterState.printerError(String message) = PrinterError;
  const factory PrinterState.printResult(bool isPrinted) = PrintSucceeded;
}
