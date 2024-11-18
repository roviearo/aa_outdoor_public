import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../../domain/entities/package.dart';
import '../../domain/repositories/package_repository.dart';
import '../datasources/package_remote_data_source.dart';

class PackageRepositoryImplementation implements PackageRepository {
  PackageRepositoryImplementation(this._packageRemoteDataSource);

  final PackageRemoteDataSource _packageRemoteDataSource;

  @override
  ResultVoid addPackage(
      String name, int price, GroupingEquipment groupingEquipment) async {
    try {
      final result = await _packageRemoteDataSource.addPackage(
          name, price, groupingEquipment);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid updatePackage(
    String id,
    String name,
    int price,
    GroupingEquipment oldGroupingEquipment,
    GroupingEquipment groupingEquipment,
  ) async {
    try {
      final result = await _packageRemoteDataSource.updatePackage(
          id, name, price, oldGroupingEquipment, groupingEquipment);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deletePackage(String id) async {
    try {
      await _packageRemoteDataSource.deletePackage(id);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Package> getDetailPackage(String id) async {
    try {
      final result = await _packageRemoteDataSource.getDetailPackage(id);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Package>> getListPackage() async {
    try {
      final result = await _packageRemoteDataSource.getListPackage();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
