
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../modules/serach/search.dart';
import '../widgets/components.dart';

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ButtonAndIconsColor(),
            elevation: 2.0,
            title: const Text(
              'Egy Tour',
              style: TextStyle(fontSize: 30),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 30,
                ),
                onPressed: () {
                  navigateto(context, SearchScreen());
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  size: 30.0,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => personal(),
                  //   ),
                  // );
                },
              ),
            ],
          ),
          // body: ConditionalBuilder(
          //   condition: SocialCubit.get(context).userModel != null,
          //   builder: (context) {
          //     var model = FirebaseAuth.instance.currentUser!.emailVerified;
          //     print(model);
          //     return Column(
          //       children: [
          //         if (!model)
          //           Container(
          //             color: Colors.amber.withOpacity(.6),
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 20),
          //               child: Row(
          //                 children: [
          //                   const Icon(
          //                     Icons.info_outline,
          //                   ),
          //                   const SizedBox(
          //                     width: 10,
          //                   ),
          //                   const Expanded(
          //                       child: Text('please verify your email')),
          //                   const SizedBox(
          //                     width: 20,
          //                   ),
          //                   defaultTextButton(
          //                       function: () {
          //                         FirebaseAuth.instance.currentUser!
          //                             .sendEmailVerification()
          //                             .then((value) {
          //                           showToast(
          //                               text: 'check your mail',
          //                               state: ToastStates.SUCCESS);
          //                         }).catchError((error) {});
          //                       },
          //                       text: 'send')
          //                 ],
          //               ),
          //             ),
          //           ),
          //       ],
          //     );
          //   },
          //   fallback: (context) => Container(),
          // ),
        );
      },
    );
  }
}
