import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/printer_repository.dart';

class GetBluetoothMacAddress extends UsecaseWithoutParams<String?> {
  GetBluetoothMacAddress(this._printerRepository);

  final PrinterRepository _printerRepository;

  @override
  ResultFuture<String?> call() => _printerRepository.getBluetoothMacAddress();
}
