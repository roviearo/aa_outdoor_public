import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/rental.dart';
import '../repositories/rental_repository.dart';

class SearchRental extends UsecaseWithParams<List<Rental>, SearchRentalParams> {
  SearchRental(this._rentalRepository);
  final RentalRepository _rentalRepository;

  @override
  ResultFuture<List<Rental>> call(SearchRentalParams params) =>
      _rentalRepository.searchRental(params.query);
}

class SearchRentalParams extends Equatable {
  const SearchRentalParams({required this.query});
  final String query;

  @override
  List<Object> get props => [query];
}
