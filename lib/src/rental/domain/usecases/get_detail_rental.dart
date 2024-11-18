import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/rental.dart';
import '../repositories/rental_repository.dart';

class GetDetailRental extends UsecaseWithParams<Rental, GetDetailRentalParams> {
  GetDetailRental(this._rentalRepository);
  final RentalRepository _rentalRepository;

  @override
  ResultFuture<Rental> call(GetDetailRentalParams params) =>
      _rentalRepository.getDetailRental(params.id);
}

class GetDetailRentalParams extends Equatable {
  const GetDetailRentalParams({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
