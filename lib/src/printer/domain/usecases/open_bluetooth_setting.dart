import '../../../../core/usecase/usecase.dart';
import '../repositories/printer_repository.dart';

class OpenBluetoothSetting extends Usecase<void> {
  OpenBluetoothSetting(this._printerRepository);

  final PrinterRepository _printerRepository;

  @override
  void call() => _printerRepository.openBluetoothSetting();
}
