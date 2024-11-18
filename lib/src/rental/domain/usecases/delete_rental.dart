import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/rental_repository.dart';

class DeleteRental extends UsecaseWithParams<void, DeleteRentalParams> {
  DeleteRental(this._rentalRepository);
  final RentalRepository _rentalRepository;

  @override
  ResultFuture<void> call(DeleteRentalParams params) =>
      _rentalRepository.deleteRental(params.id);
}

class DeleteRentalParams extends Equatable {
  const DeleteRentalParams({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
