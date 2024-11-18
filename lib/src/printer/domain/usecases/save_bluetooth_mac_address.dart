import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/printer_repository.dart';

class SaveBluetoothMacAddress
    extends UsecaseWithParams<void, SaveBluetoothMacAddressParams> {
  SaveBluetoothMacAddress(this._printerRepository);

  final PrinterRepository _printerRepository;

  @override
  ResultFuture<void> call(SaveBluetoothMacAddressParams params) =>
      _printerRepository.saveBluetoothMacAddress(params.value);
}

class SaveBluetoothMacAddressParams extends Equatable {
  const SaveBluetoothMacAddressParams({required this.value});
  final String value;

  @override
  List<Object> get props => [value];
}
