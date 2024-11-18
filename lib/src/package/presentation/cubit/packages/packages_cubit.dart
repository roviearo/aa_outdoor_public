import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/package.dart';
import '../../../domain/usecases/delete_package.dart';
import '../../../domain/usecases/get_list_package.dart';

part 'packages_state.dart';
part 'packages_cubit.freezed.dart';

enum PackagesStatus {
  initial,
  loading,
  loaded,
  error,
  success,
  deleting,
  deleted
}

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit({
    required GetListPackage getListPackage,
    required DeletePackage deletePackage,
  })  : _getListPackage = getListPackage,
        _deletePackage = deletePackage,
        super(const PackagesState.initial());

  final GetListPackage _getListPackage;
  final DeletePackage _deletePackage;

  loadListPackage() async {
    emit(state.copyWith(status: PackagesStatus.loading));

    final result = await _getListPackage.call();

    result.fold(
      (failure) => emit(state.copyWith(
        status: PackagesStatus.error,
        message: failure.message,
      )),
      (listPackage) => emit(state.copyWith(
          status: PackagesStatus.success, listPackage: listPackage)),
    );
  }

  deletePackage(String packageId) async {
    emit(state.copyWith(status: PackagesStatus.deleting));

    final result =
        await _deletePackage.call(DeletePackageParams(id: packageId));

    result.fold(
      (failure) => emit(state.copyWith(
        status: PackagesStatus.error,
        message: failure.message,
      )),
      (_) {
        emit(state.copyWith(status: PackagesStatus.deleted));
        loadListPackage();
      },
    );
  }
}
