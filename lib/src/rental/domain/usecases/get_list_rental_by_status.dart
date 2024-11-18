import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/rental.dart';
import '../repositories/rental_repository.dart';

class GetListRentalByStatus
    extends UsecaseWithParams<List<Rental>, GetListRentalByStatusParams> {
  GetListRentalByStatus(this._rentalRepository);
  final RentalRepository _rentalRepository;

  @override
  ResultFuture<List<Rental>> call(GetListRentalByStatusParams params) =>
      _rentalRepository.getListRentalByStatus(params.status);
}

class GetListRentalByStatusParams extends Equatable {
  const GetListRentalByStatusParams({required this.status});
  final String status;

  @override
  List<Object> get props => [status];
}
