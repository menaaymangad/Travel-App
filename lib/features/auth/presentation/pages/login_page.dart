import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/social/presentation/pages/navigation_page.dart';
import 'package:travelapp/widgets/components.dart';
import 'package:travelapp/widgets/custom_button.dart';
import 'package:travelapp/widgets/custom_text_field.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import 'register_page.dart';
import 'reset_password_page.dart';

/// Login page for user authentication
class LoginPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/login';

  /// Creates a new [LoginPage] instance
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            showToast(
              text: state.message,
              state: ToastStates.ERROR,
            );
          }
          if (state is AuthAuthenticated) {
            navigateAndfinish(context, const NavigationPage());
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              centerTitle: true,
              title: Text(
                'Login',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              toolbarHeight: 80,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Theme.of(context).colorScheme.primary,
                              image: const DecorationImage(
                                image: AssetImage("assets/images/launch.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _emailController,
                          hint: 'Enter your email address',
                          label: 'Email Address',
                          suffixIcon: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0),
                        CustomTextField(
                          controller: _passwordController,
                          hint: 'Enter your password',
                          label: 'Password',
                          isPassword: !cubit.isPasswordVisible,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            icon: cubit.suffix,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30.0),
                        if (state is AuthLoading)
                          const CircularProgressIndicator()
                        else
                          CustomButton(
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            },
                            buttonName: 'Login',
                          ),
                        const SizedBox(height: 15.0),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              ResetPasswordPage.routeName,
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RegisterPage.routeName,
                                );
                              },
                              child: Text(
                                'Register',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
