import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/package.dart';
import '../repositories/package_repository.dart';

class GetListPackage extends UsecaseWithoutParams<List<Package>> {
  GetListPackage(this._packageRepository);

  final PackageRepository _packageRepository;

  @override
  ResultFuture<List<Package>> call() => _packageRepository.getListPackage();
}
