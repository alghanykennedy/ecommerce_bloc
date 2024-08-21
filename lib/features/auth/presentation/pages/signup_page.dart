import 'package:ecommerce_bloc/core/theme/app_pallete.dart';
import 'package:ecommerce_bloc/core/shared/widgets/show_snackbar.dart';
import 'package:ecommerce_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_bloc/features/auth/presentation/widget/auth_field.dart';
import 'package:ecommerce_bloc/features/auth/presentation/widget/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _onSignUp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignUp(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              name: nameController.text.trim(),
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

            return SignUpForm(
              formKey: formKey,
              nameController: nameController,
              emailController: emailController,
              passwordController: passwordController,
              onSignUpPressed: () => _onSignUp(context),
              isLoading: isLoading,
            );
          },
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onSignUpPressed,
    required this.isLoading,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSignUpPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign Up.',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          AuthField(
            controller: nameController,
            hintText: 'Name',
          ),
          const SizedBox(height: 15),
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
            buttonText: 'Sign Up',
            onPressed: onSignUpPressed,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign In',
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
