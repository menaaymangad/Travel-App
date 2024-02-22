import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/widgets/custom_text_field.dart';

import '../layout/navigation_screen.dart';
import '../widgets/components.dart';
import '../shared/network/local/cach_helper.dart';
import '../widgets/custom_button.dart';
import 'register_screen.dart';
import '../modules/reset/reset_screen.dart';
import '../modules/login/cubit/cubit.dart';
import '../modules/login/cubit/states.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});
  static String id = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  String? emailAddress;

  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginSuccessState) {
            CachHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndfinish(context, const Navigationbar());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: KprimaryColor,
              centerTitle: true,
              title: const Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffffffff),
                ),
              ),
              toolbarHeight: 100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(60),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              color: Color(0xff5181b8),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/launch.jpg"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          function: (data) {
                         emailAddress = data;
                      },
                          hint: 'Enter your email address',
                          label: 'Email Address',
                          suffixIcon:const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        CustomTextField(
                          
                          suffixIcon: SocialLoginCubit.get(context).suffix,
                         
                          function: (data) {
                        password = data;
                      },
                      label: 'Password',
                      hint: 'Enter your password',
                         
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomButton(
                      function: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await loginUser();
                            ShowSnackBar(context, 'login success.');
                            Navigator.pushNamed(context, ChatScreen.id,
                                arguments: emailAddress);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ShowSnackBar(
                                  context, 'No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              ShowSnackBar(context,
                                  'Wrong password provided for that user.');
                            }
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      buttonName: 'Login',
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'don\'t have an account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              'RegisterScreen',
                            );
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
