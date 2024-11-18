import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../../rental/domain/entities/rental.dart';
import '../repositories/printer_repository.dart';

class PrintListEquipment
    extends UsecaseWithParams<bool, PrintListEquipmentParams> {
  PrintListEquipment(this._printerRepository);

  final PrinterRepository _printerRepository;

  @override
  ResultFuture<bool> call(PrintListEquipmentParams params) =>
      _printerRepository.printListEquipments(params.rental);
}

class PrintListEquipmentParams extends Equatable {
  const PrintListEquipmentParams({required this.rental});

  final Rental rental;

  @override
  List<Object> get props => [rental];
}
