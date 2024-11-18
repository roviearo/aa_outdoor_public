import 'package:dartz/dartz.dart';

import '/core/errors/exception.dart';
import '/core/errors/failure.dart';
import '/core/utils/typedef.dart';
import '/src/equipment/data/datasources/equipment_remote_data_source.dart';
import '/src/equipment/domain/entities/category.dart';
import '/src/equipment/domain/entities/equipment.dart';
import '/src/equipment/domain/repositories/equipment_repository.dart';

class EquipmentRepositoryImplementation implements EquipmentRepository {
  EquipmentRepositoryImplementation(this._remoteDataSource);
  final EquipmentRemoteDataSource _remoteDataSource;

  @override
  ResultVoid addCategory(String name) async {
    try {
      await _remoteDataSource.addCategory(name);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteCategory(String id) async {
    try {
      await _remoteDataSource.deleteCategory(id);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Category>> getListCategory() async {
    try {
      final result = await _remoteDataSource.getListCategory();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateCategory(String id, String name) async {
    try {
      await _remoteDataSource.updateCategory(id, name);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid addEquipment(
    String name,
    String price,
    String stockQty,
    String categoryId,
  ) async {
    try {
      await _remoteDataSource.addEquipment(name, price, stockQty, categoryId);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteEquipment(String id) async {
    try {
      await _remoteDataSource.deleteEquipment(id);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Equipment>> getListEquipment() async {
    try {
      final result = await _remoteDataSource.getListEquipments();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Equipment>> getListEquipmentsByCategory(
      String categoryId) async {
    try {
      final result =
          await _remoteDataSource.getListEquipmentsByCategory(categoryId);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateEquipment(
    String id,
    String name,
    String price,
    String stockQty,
    String categoryId,
  ) async {
    try {
      final result = await _remoteDataSource.updateEquipment(
          id, name, price, stockQty, categoryId);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Equipment>> searchEquipment(String query) async {
    try {
      final result = await _remoteDataSource.searchEquipment(query);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
