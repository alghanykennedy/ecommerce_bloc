import 'package:ecommerce_bloc/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> signInWithEmailPassword({
    required String email,
    required String password,
  });
}
