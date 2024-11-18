part of 'printer_bloc.dart';

@freezed
class PrinterEvent with _$PrinterEvent {
  const factory PrinterEvent.loadBondedDevice() = LoadBondedDevice;
  const factory PrinterEvent.checkBluetoothIsEnabled() =
      CheckBluetoothIsEnabled;
  const factory PrinterEvent.openBluetoothSettingEvent() =
      OpenBluetoothSettingEvent;
  const factory PrinterEvent.printBill(
      Rental rental, int? payment, int? change) = PrintBillEvent;
  const factory PrinterEvent.printListEquipment(Rental rental) =
      PrintListEquipmentEvent;
}
