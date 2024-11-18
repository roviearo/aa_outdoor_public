import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/rental_repository.dart';

class ReturnRental extends UsecaseWithParams<void, ReturnRentalParams> {
  ReturnRental(this._rentalRepository);
  final RentalRepository _rentalRepository;

  @override
  ResultFuture<void> call(ReturnRentalParams params) =>
      _rentalRepository.returnRental(params.id);
}

class ReturnRentalParams extends Equatable {
  const ReturnRentalParams({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
