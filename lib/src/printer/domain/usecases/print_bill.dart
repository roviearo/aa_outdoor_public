import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../../rental/domain/entities/rental.dart';
import '../repositories/printer_repository.dart';

class PrintBill extends UsecaseWithParams<bool, PrintBillParams> {
  PrintBill(this._printerRepository);

  final PrinterRepository _printerRepository;

  @override
  ResultFuture<bool> call(PrintBillParams params) =>
      _printerRepository.printBill(
        params.rental,
        params.payment,
        params.change,
      );
}

class PrintBillParams extends Equatable {
  const PrintBillParams({
    required this.rental,
    required this.payment,
    required this.change,
  });

  final Rental rental;
  final int? payment;
  final int? change;

  @override
  List<Object?> get props => [rental, payment, change];
}
