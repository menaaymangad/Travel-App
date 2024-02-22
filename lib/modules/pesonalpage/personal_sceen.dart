
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/models/users.dart';
import 'package:travelapp/modules/follow/followers.dart';
import 'package:travelapp/widgets/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../widgets/constants.dart';
import '../follow/following.dart';
import '../postscreen/add_post_screen.dart';
import '../postscreen/postmodel.dart';
import '../settings/editscreen.dart';

class personal extends StatefulWidget {
  String? userID;
  personal({Key? key, this.userID}) : super(key: key);

  @override
  _personalState createState() => _personalState();
}

class _personalState extends State<personal> {
  var searchController = TextEditingController();
  // List<PostModel> posts = [];
  // List<String> postsId = [];
  // List<int> likes = [];
  bool postsLoaded = false;
  SocialUserModel? selectedUser;
  Future<SocialUserModel?> getUserDataFromId(String uid) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    selectedUser = SocialUserModel.fromJson(doc.data() as Map<String, dynamic>);
    print(selectedUser!.uId);
    //  await getPostsFromId(selectedUser!.uId);
    return selectedUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserDataFromId(widget.userID ?? uId),
        builder: (context, AsyncSnapshot<SocialUserModel?> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var userModel = SocialCubit.get(context).userModel!.uId;
              SocialUserModel selectedUser = snapshot.data!;
              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: ButtonAndIconsColor(),
                    elevation: 7.0,
                    actions: [
                      MaterialButton(
                          onPressed: () {
                            signOut(context);
                          },
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 180.0,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  height: 140.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        selectedUser.cover,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 50.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 48.0,
                                  backgroundImage: NetworkImage(
                                    selectedUser.image,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          selectedUser.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          selectedUser.bio,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 23.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: statWidget("Posts",
                                  "${SocialCubit.get(context).posts.length}"),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  child: statWidget("Followers",
                                      "${SocialCubit.get(context).followers.length}"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => followers(),
                                      ),
                                    );
                                  }),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  child: statWidget("Following",
                                      "${SocialCubit.get(context).following.length}"),
                                  onTap: () {
                                    navigateto(context, const following());
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7.0),
                        Row(
                          children: [
                            if (widget.userID == null)
                              Expanded(
                                flex: 2,
                                child: OutlinedButton(
                                  onPressed: () {
                                    navigateto(context, NewPostScreen());
                                  },
                                  style: const ButtonStyle(),
                                  child: const Text('Add photos'),
                                ),
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (widget.userID != null)
                              Expanded(
                                flex: 2,
                                child: OutlinedButton(
                                  onPressed: () {
                                    bool first = true;
                                    bool second = true;
                                    if (first == true) {
                                      final UserDoc = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc('followers');
                                      UserDoc.update({
                                        'followers': '$followers',
                                      });
                                      first == false;
                                    }
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(child: Text('Follow')),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (widget.userID == null)
                              Expanded(
                                flex: 2,
                                child: OutlinedButton(
                                  onPressed: () {
                                    navigateto(context, EditProfileScreen());
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(child: Text('Edit Profile')),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Center(
                                        child: Icon(
                                          Icons.edit,
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(0),
                          child: Divider(
                            height: 18.0,
                            thickness: 0.8,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: ConditionalBuilder(
                            condition:
                                SocialCubit.get(context).posts.isNotEmpty &&
                                    SocialCubit.get(context).userModel != null,
                            builder: (context) => SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        buildPostItem(
                                            SocialCubit.get(context)
                                                .posts
                                                .where((element) {
                                              if (widget.userID == null) {
                                                return element.uId == uId;
                                              } else {
                                                return element.uId != uId;
                                              }
                                            }).toList()[index],
                                            context,
                                            index),
                                    //SocialCubit.get(context).posts[index], context, index),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 8.0,
                                    ),
                                    itemCount: SocialCubit.get(context)
                                        .posts
                                        .where((element) {
                                          if (widget.userID == null) {
                                            return element.uId == uId;
                                          } else {
                                            return element.uId != uId;
                                          }
                                        })
                                        .toList()
                                        .length,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        )
                      ],
                    ),
                  ));
            },
          );
        });
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      model.image,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name,
                              style: const TextStyle(
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          model.dateTime,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                model.text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  top: 5.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 6.0,
                        ),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style:
                                  Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.blue,
                                      ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 6.0,
                        ),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#flutter',
                              style:
                                  Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.blue,
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15.0),
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          model.postImage,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '0 comment',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                              model.image,
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'write a comment ...',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

Widget statWidget(String title, String state) {
  return Expanded(
    child: Column(
      children: [
        Text(
          state,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );
}
