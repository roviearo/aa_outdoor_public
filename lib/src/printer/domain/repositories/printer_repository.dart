import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../../core/utils/typedef.dart';
import '../../../rental/domain/entities/rental.dart';

abstract class PrinterRepository {
  ResultFuture<List<BluetoothInfo>> getBondedDevices();
  ResultFuture<bool> connectToPrinter(String macAddress);
  void openBluetoothSetting();
  ResultFuture<bool> isBluetoothEnabled();
  ResultFuture<bool> printBill(Rental rental, int? payment, int? change);
  ResultFuture<bool> printListEquipments(Rental rental);
  ResultVoid saveBluetoothMacAddress(String value);
  ResultFuture<String?> getBluetoothMacAddress();
}
