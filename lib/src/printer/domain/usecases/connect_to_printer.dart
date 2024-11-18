import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/printer_repository.dart';

class ConnectToPrinter extends UsecaseWithParams<bool, ConnectToPrinterParams> {
  ConnectToPrinter(this._printerRepository);

  final PrinterRepository _printerRepository;

  @override
  ResultFuture<bool> call(ConnectToPrinterParams params) =>
      _printerRepository.connectToPrinter(params.macAddress);
}

class ConnectToPrinterParams extends Equatable {
  const ConnectToPrinterParams({required this.macAddress});

  final String macAddress;

  @override
  List<Object> get props => [macAddress];
}
