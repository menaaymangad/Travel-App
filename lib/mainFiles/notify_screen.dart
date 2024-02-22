
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/models/users.dart';
import 'package:travelapp/modules/chat/chat_details.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../widgets/components.dart';

class Notifyme extends StatefulWidget {
  const Notifyme({Key? key}) : super(key: key);

  @override
  _NotifymeState createState() => _NotifymeState();
}

class _NotifymeState extends State<Notifyme> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context, state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) =>ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index]) ,
            separatorBuilder:  (context, index) => mydivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) => const Center(
              child: CircularProgressIndicator()),
        );
      },
    );

  }
  Widget buildChatItem(SocialUserModel model) => InkWell(
    onTap: (){
      navigateto(context,
          ChatDetailsScreen(
            userModel: model,
          )
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row (
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                '${model.image}'),
          ),
          const SizedBox(
              width : 15.0
          ),
          Text('${model.name}',
            style: const TextStyle(
              height: 1.4,
            ),
          ),
        ],

      ),
    ),
  );
}
