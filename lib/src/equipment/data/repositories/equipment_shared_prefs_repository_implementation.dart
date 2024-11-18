import 'package:dartz/dartz.dart';

import '/core/errors/exception.dart';
import '/core/errors/failure.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/data/datasources/equipment_shared_prefs_remote_data_source.dart';
import '/src/equipment/domain/repositories/equipment_shared_prefs_repository.dart';

class EquipmentSharedPrefsRepositoryImplementation
    implements EquipmentSharedPrefsRepository {
  EquipmentSharedPrefsRepositoryImplementation(this._prefsRemoteDataSource);

  final EquipmentSharedPrefsRemoteDataSource _prefsRemoteDataSource;

  @override
  ResultFuture<int?> getEquipmentCategory() async {
    try {
      final result = await _prefsRemoteDataSource.getEquipmentCategory();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<int?> getEquipmentView() async {
    try {
      final result = await _prefsRemoteDataSource.getEquipmentView();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveEquipmentCategory(int value) async {
    try {
      await _prefsRemoteDataSource.saveEquipmentCategory(value);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveEquipmentView(int value) async {
    try {
      await _prefsRemoteDataSource.saveEquipmentView(value);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
