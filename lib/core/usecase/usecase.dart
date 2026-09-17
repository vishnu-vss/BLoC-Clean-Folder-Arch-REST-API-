import 'package:fpdart/fpdart.dart';

abstract class UseCase<T, P> {
  Future<Either<Exception, T>> call(P params);
}

class NoParams {}
