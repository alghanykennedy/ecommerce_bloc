import 'package:ecommerce_bloc/features/auth/domain/usecases/user_sign_in.dart';
import 'package:ecommerce_bloc/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase userSignUp;
  final UserSignInUseCase userSignIn;

  AuthBloc({required this.userSignUp, required this.userSignIn})
      : super(AuthInitial()) {
    on<AuthSignUp>(_signUpEvent);
    on<AuthSignIn>(_signInEvent);
  }

  void _signUpEvent(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    result.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthLoaded()),
    );
  }

  void _signInEvent(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthLoaded()),
    );
  }
}
