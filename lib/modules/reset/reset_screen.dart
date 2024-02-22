import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../widgets/components.dart';

class ResetScreen extends StatelessWidget {
  var resetEmailController = TextEditingController();
  var emailController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  ResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff5181b8),
              centerTitle: true,
              title: const Text(
                'Reset Password',
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
            body: Column(
              key: formkey,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        color: Color(0xff5181b8),
                        image: DecorationImage(
                            image: AssetImage("images/launch.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter Your Email',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email address';
                      }
                      return null;
                    },
                    controller: resetEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2a5885)),
                      ),
                      hintText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: ConditionalBuilder(
                    condition: state is! SocialGetUserLoadingState,
                    builder: (context) => defaultButton(
                        function: () {
                          if (formkey.currentState!.validate()) {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: resetEmailController.text)
                                .then((value) {
                              showToast(
                                  text: 'check your mail',
                                  state: ToastStates.SUCCESS);
                            }).catchError((error) {});
                          }
                        },
                        text: 'Send Link'),
                    fallback: (BuildContext context) {
                      throw Exception('Invalid');
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
