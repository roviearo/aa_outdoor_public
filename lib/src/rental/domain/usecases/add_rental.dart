import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../../../package/domain/entities/package.dart';
import '../repositories/rental_repository.dart';

class AddRental extends UsecaseWithParams<String, AddRentalParams> {
  AddRental(this._rentalRepository);
  final RentalRepository _rentalRepository;

  @override
  ResultFuture<String> call(AddRentalParams params) =>
      _rentalRepository.addRental(
        params.name,
        params.address,
        params.phoneNumber,
        params.nameIdCard,
        params.idCardType,
        params.startDate,
        params.endDate,
        params.groupingEquipment,
        params.groupingPackage,
        params.paymentNominal,
        params.paymentType,
        params.returnNominal,
        params.totalPrice,
      );
}

class AddRentalParams extends Equatable {
  const AddRentalParams({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.nameIdCard,
    required this.idCardType,
    required this.startDate,
    required this.endDate,
    required this.groupingEquipment,
    required this.groupingPackage,
    required this.paymentNominal,
    required this.paymentType,
    required this.returnNominal,
    required this.totalPrice,
  });

  final String name;
  final String address;
  final String phoneNumber;
  final String nameIdCard;
  final String idCardType;
  final DateTime startDate;
  final DateTime endDate;
  final GroupingEquipment groupingEquipment;
  final GroupingPackage groupingPackage;
  final int paymentNominal;
  final String paymentType;
  final int returnNominal;
  final int totalPrice;

  @override
  List<Object> get props {
    return [
      name,
      address,
      phoneNumber,
      nameIdCard,
      idCardType,
      startDate,
      endDate,
      groupingEquipment,
      groupingPackage,
      paymentNominal,
      paymentType,
      returnNominal,
      totalPrice,
    ];
  }
}
