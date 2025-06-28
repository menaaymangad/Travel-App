import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../widgets/components.dart' as components;
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

/// Reset password page
class ResetPasswordPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/reset-password';

  /// Creates a new [ResetPasswordPage] instance
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            components.showToast(
              text: state.message,
              state: components.ToastStates.ERROR,
            );
          }
          if (state is AuthPasswordResetSent) {
            components.showToast(
              text: 'Password reset link sent to your email',
              state: components.ToastStates.SUCCESS,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              centerTitle: true,
              title: Text(
                'Reset Password',
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
                        Text(
                          'Enter your email address and we will send you a link to reset your password.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 30),
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
                        const SizedBox(height: 30.0),
                        if (state is AuthLoading)
                          const CircularProgressIndicator()
                        else
                          CustomButton(
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.resetPassword(
                                    email: _emailController.text);
                              }
                            },
                            buttonName: 'Send Reset Link',
                          ),
                        const SizedBox(height: 15.0),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Back to Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
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
