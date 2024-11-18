import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/package.dart';
import '../../../domain/usecases/delete_package.dart';
import '../../../domain/usecases/get_detail_package.dart';

part 'detail_package_state.dart';
part 'detail_package_cubit.freezed.dart';

enum DetailPackageStatus { initial, loading, loaded, error, deleted }

class DetailPackageCubit extends Cubit<DetailPackageState> {
  DetailPackageCubit({
    required GetDetailPackage getDetailPackage,
    required DeletePackage deletePackage,
  })  : _getDetailPackage = getDetailPackage,
        _deletePackage = deletePackage,
        super(const DetailPackageState.initial());

  final GetDetailPackage _getDetailPackage;
  final DeletePackage _deletePackage;

  getDetailPackage(String packageId) async {
    final result =
        await _getDetailPackage.call(GetDetailPackageParams(id: packageId));

    result.fold(
      (failure) => emit(state.copyWith(
          status: DetailPackageStatus.error, message: failure.message)),
      (package) => loadDetailPackage(package),
    );
  }

  loadDetailPackage(Package package) {
    emit(state.copyWith(status: DetailPackageStatus.loading));

    emit(state.copyWith(status: DetailPackageStatus.loaded, package: package));
  }

  deletePackage(String packageId) async {
    final result =
        await _deletePackage.call(DeletePackageParams(id: packageId));

    result.fold(
      (failure) => emit(state.copyWith(
        status: DetailPackageStatus.error,
        message: failure.message,
      )),
      (_) => emit(state.copyWith(status: DetailPackageStatus.deleted)),
    );
  }
}
