import 'package:dartz/dartz.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../../rental/domain/entities/rental.dart';
import '../../domain/repositories/printer_repository.dart';
import '../datasources/printer_remote_data_source.dart';

class PrinterRepositoryImplementation implements PrinterRepository {
  PrinterRepositoryImplementation(this._printerRemoteDataSource);

  final PrinterRemoteDataSource _printerRemoteDataSource;

  @override
  ResultFuture<bool> connectToPrinter(String macAddress) async {
    try {
      final result =
          await _printerRemoteDataSource.connectToPrinter(macAddress);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<BluetoothInfo>> getBondedDevices() async {
    try {
      final result = await _printerRemoteDataSource.getBondedDevices();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  void openBluetoothSetting() {
    _printerRemoteDataSource.openBluetoothSetting();
  }

  @override
  ResultFuture<bool> isBluetoothEnabled() async {
    try {
      final result = await _printerRemoteDataSource.isBluetoothEnabled();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> printBill(Rental rental, int? payment, int? change) async {
    try {
      final result =
          await _printerRemoteDataSource.printBill(rental, payment, change);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> printListEquipments(Rental rental) async {
    try {
      final result = await _printerRemoteDataSource.printListEquipments(rental);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String?> getBluetoothMacAddress() async {
    try {
      final result = await _printerRemoteDataSource.getBluetoothMacAddress();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveBluetoothMacAddress(String value) async {
    try {
      await _printerRemoteDataSource.saveBluetoothMacAddress(value);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
