import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../../../package/domain/entities/package.dart';
import '../../domain/entities/rental.dart';
import '../../domain/repositories/rental_repository.dart';
import '../datasources/rental_remote_data_source.dart';

class RentalRepositoryImplementation implements RentalRepository {
  RentalRepositoryImplementation(this._remoteDataSource);
  final RentalRemoteDataSource _remoteDataSource;

  @override
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
  ) async {
    try {
      final result = await _remoteDataSource.addRental(
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
      );

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteRental(String id) async {
    try {
      await _remoteDataSource.deleteRental(id);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Rental> getDetailRental(String id) async {
    try {
      final result = await _remoteDataSource.getDetailRental(id);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Rental>> getListRental() async {
    try {
      final result = await _remoteDataSource.getListRental();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Rental>> getListRentalByStatus(String status) async {
    try {
      final result = await _remoteDataSource.getListRentalByStatus(status);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid returnRental(String id) async {
    try {
      await _remoteDataSource.returnRental(id);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Rental>> searchRental(String query) async {
    try {
      final result = await _remoteDataSource.searchRental(query);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
