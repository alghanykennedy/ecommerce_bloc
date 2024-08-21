import 'package:ecommerce_bloc/core/shared/widgets/show_snackbar.dart';
import 'package:ecommerce_bloc/core/theme/app_pallete.dart';
import 'package:ecommerce_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_bloc/features/auth/presentation/pages/signup_page.dart';
import 'package:ecommerce_bloc/features/auth/presentation/widget/auth_field.dart';
import 'package:ecommerce_bloc/features/auth/presentation/widget/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSignIn(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      showSnackBar(context, state.message);
    } else if (state is AuthLoaded) {
      // Navigate to the next screen if sign-up is successful
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   BlogPage.route(),
      //   (route) => false,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: _onAuthStateChanged,
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SignInForm(
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
              onSignInPressed: () => _onSignIn(context),
              isLoading: isLoading,
            );
          },
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSignInPressed,
    required this.isLoading,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSignInPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign In.',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          AuthField(
            controller: emailController,
            hintText: 'Email',
          ),
          const SizedBox(height: 15),
          AuthField(
            controller: passwordController,
            hintText: 'Password',
            isObscureText: true,
          ),
          const SizedBox(height: 20),
          AuthGradientButton(
            isLoading: isLoading,
            buttonText: 'Sign In',
            onPressed: onSignInPressed,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(context, SignUpPage.route());
            },
            child: RichText(
              text: TextSpan(
                text: 'Don\'t have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
