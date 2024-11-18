import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/package_repository.dart';

class DeletePackage extends UsecaseWithParams<void, DeletePackageParams> {
  DeletePackage(this._packageRepository);

  final PackageRepository _packageRepository;

  @override
  ResultFuture<void> call(DeletePackageParams params) =>
      _packageRepository.deletePackage(params.id);
}

class DeletePackageParams extends Equatable {
  const DeletePackageParams({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
