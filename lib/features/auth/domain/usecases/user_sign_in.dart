import 'package:ecommerce_bloc/core/error/failures.dart';
import 'package:ecommerce_bloc/core/shared/base_usecase/usecase.dart';
import 'package:ecommerce_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignInUseCase implements UseCase<String, UserSignInParams> {
  UserSignInUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, String>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
