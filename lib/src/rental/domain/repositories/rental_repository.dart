import '../../../../core/utils/typedef.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../../../package/domain/entities/package.dart';
import '../entities/rental.dart';

abstract class RentalRepository {
  ResultFuture<List<Rental>> getListRental();
  ResultFuture<List<Rental>> getListRentalByStatus(String status);
  ResultFuture<Rental> getDetailRental(String id);
  ResultVoid returnRental(String id);
  ResultVoid deleteRental(String id);
  ResultFuture<String> addRental(
    String name,
    String address,
    String phoneNumber,
    String nameIdCard,
    String idCardType,
    DateTime startDate,
    DateTime endDate,
    GroupingEquipment groupingEquipment,
    GroupingPackage groupingPackage,
    int paymentNominal,
    String paymentType,
    int returnNominal,
    int totalPrice,
  );
  ResultFuture<List<Rental>> searchRental(String query);
}
