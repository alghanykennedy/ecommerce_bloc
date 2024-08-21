import 'package:ecommerce_bloc/core/error/failures.dart';
import 'package:ecommerce_bloc/core/shared/base_usecase/usecase.dart';
import 'package:ecommerce_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpUseCase implements UseCase<String, UserSignUpParams> {
  UserSignUpUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
