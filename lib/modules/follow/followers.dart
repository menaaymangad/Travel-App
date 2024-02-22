
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../layout/cubit/cubit.dart';

class followers extends StatelessWidget {
  const followers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit.get(context).userModel;
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConditionalBuilder(
              condition: SocialCubit.get(context).followers.isNotEmpty &&
                  SocialCubit.get(context).userModel != null,
              builder: (context) => SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => followersList(
                      SocialCubit.get(context).followers[index],
                      context,
                      index),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8.0,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
              ),
              fallback: (context) => Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.blueGrey,
                child: const FittedBox(
                  child: Text(
                    'No followers .....',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  Widget followersList(user, context, index) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePicture),
            ),
            title: Text(user.name),
            subtitle: Text(user.bio),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
