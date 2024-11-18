import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/printer_repository.dart';

class GetBondedDevices extends UsecaseWithoutParams<List<BluetoothInfo>> {
  GetBondedDevices(this._printerRepository);

  final PrinterRepository _printerRepository;

  @override
  ResultFuture<List<BluetoothInfo>> call() =>
      _printerRepository.getBondedDevices();
}
