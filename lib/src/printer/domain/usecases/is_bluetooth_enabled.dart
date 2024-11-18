import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/printer_repository.dart';

class IsBluetoothEnabled extends UsecaseWithoutParams<bool> {
  IsBluetoothEnabled(this._printerRepository);

  final PrinterRepository _printerRepository;

  @override
  ResultFuture<bool> call() => _printerRepository.isBluetoothEnabled();
}
