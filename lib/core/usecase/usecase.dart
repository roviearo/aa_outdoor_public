import '/core/utils/typedef.dart';

abstract class Usecase<Type> {
  const Usecase();

  Type call();
}

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}

abstract class UsecaseStream<Type> {
  const UsecaseStream();

  Stream<Type> call();
}
