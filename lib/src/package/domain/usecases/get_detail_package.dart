import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/package.dart';
import '../repositories/package_repository.dart';

class GetDetailPackage
    extends UsecaseWithParams<Package, GetDetailPackageParams> {
  GetDetailPackage(this._packageRepository);

  final PackageRepository _packageRepository;

  @override
  ResultFuture<Package> call(GetDetailPackageParams params) =>
      _packageRepository.getDetailPackage(params.id);
}

class GetDetailPackageParams extends Equatable {
  const GetDetailPackageParams({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
