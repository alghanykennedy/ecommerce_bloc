import 'package:ecommerce_bloc/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
