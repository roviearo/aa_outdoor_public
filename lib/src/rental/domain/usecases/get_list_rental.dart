import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/rental.dart';
import '../repositories/rental_repository.dart';

class GetListRental extends UsecaseWithoutParams<List<Rental>> {
  GetListRental(this._rentalRepository);
  final RentalRepository _rentalRepository;

  @override
  ResultFuture<List<Rental>> call() => _rentalRepository.getListRental();
}
