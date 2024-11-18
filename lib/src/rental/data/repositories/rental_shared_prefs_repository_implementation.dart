import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/repositories/rental_shared_prefs_repository.dart';
import '../datasources/rental_shared_prefs_remote_data_source.dart';

class RentalSharedPrefsRepositoryImplementation
    implements RentalSharedPrefsRepository {
  RentalSharedPrefsRepositoryImplementation(this._prefsRemoteDataSource);
  final RentalSharedPrefsRemoteDataSource _prefsRemoteDataSource;

  @override
  ResultFuture<int?> getRentalView() async {
    try {
      final result = await _prefsRemoteDataSource.getRentalView();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveRentalView(int value) async {
    try {
      final result = await _prefsRemoteDataSource.saveRentalView(value);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
