// import 'dart:typed_data';
//
// import 'package:egytour/modules/postscreen/store.dart';
// import 'package:egytour/modules/postscreen/utils.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../models/users.dart';
//
//
// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddPostScreenState createState() => _AddPostScreenState();
// }
//
// class _AddPostScreenState extends State<AddPostScreen> {
//   Uint8List? _file;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   void postImage(
//       String uid,
//       String username,
//       String profImage,
//       ) async{
//     try{
//       String res = await FirestoreMethods().uploadPost(
//           _descriptionController.text,
//           _file!,
//           uid,
//           username,
//           profImage
//       );
//
//       if (res == "success"){
//         showSnackBar('Posted!', context);
//       }else{
//         showSnackBar(res, context);
//       }
//     }catch(e){
//       showSnackBar(e.toString(), context);
//
//     }
//   }
//
//   _selectImage(BuildContext context) async{
//     return showDialog(context: context, builder: (context){
//       return SimpleDialog(
//         title: const Text('Create a Post'),
//         children: [
//           SimpleDialogOption(
//             padding: const EdgeInsets.all(20),
//             child: const Text('Take a photo'),
//             onPressed: () async {
//               Navigator.of(context).pop();
//               Uint8List file = await pickImage(ImageSource.camera,);
//               setState((){
//                 _file = file;
//               });
//             },
//           ),
//           SimpleDialogOption(
//             padding: const EdgeInsets.all(20),
//             child: const Text('Choose From Gallary'),
//             onPressed: () async {
//               Navigator.of(context).pop();
//               Uint8List file = await pickImage(ImageSource.gallery,);
//               setState((){
//                 _file = file;
//               });
//             },
//           ),
//         ],
//       );
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//    // final User user = Provider.of<userProvider>(context).getUser;
//    //  return _file == null? Center(
//    //    child: IconButton(
//    //      icon: const Icon(Icons.upload),
//    //      onPressed: () => _selectImage(context),
//    //   ),
//    //  ):
//     return Scaffold(
//      appBar: AppBar(
//        //backgroundColor: mobileBackgroundColor,
//        leading: IconButton(
//          icon: const Icon(Icons.arrow_back),
//          onPressed: (){},
//        ),
//        title: const Text('post to'),
//        centerTitle: false,
//        actions: [
//          TextButton(
//              onPressed: () {}
//              ,
//              child: const Text(
//                'post',
//                style: TextStyle(
//                  color: Colors.blueAccent,
//                  fontWeight: FontWeight.bold,
//                  fontSize: 16,
//              ),
//              )
//          )
//        ],
//      ),
//      body: Column(
//        children: [
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              CircleAvatar(
//                backgroundImage: NetworkImage(
//                  'https://images.unsplash.com/photo-1655244995763-8fb27e73aa18?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'
//                ),
//              ),
//              SizedBox(
//                width: MediaQuery.of(context).size.width*0.4,
//                child: TextField(
//                  decoration: const InputDecoration(
//                    hintText: 'write a caption...',
//                    border: InputBorder.none,
//                  ),
//                  maxLines: 8,
//                ),
//              ),
//              SizedBox(
//                height: 45,
//                width: 45,
//                child: AspectRatio(
//                  aspectRatio: 487/451,
//                  child: Container(
//                    decoration:  BoxDecoration(
//                        image: DecorationImage(
//                            image: NetworkImage('https://images.unsplash.com/photo-1655244995763-8fb27e73aa18?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
//                            fit: BoxFit.fill,
//                            alignment: FractionalOffset.topCenter)
//                            ),
//                    ),
//                  ),
//                ),
//              const Divider(),
//            ],
//          ),
//        ],
//      ),
//    );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../widgets/components.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit.get(context).userModel;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            actions: [
              defaultTextButton(
                function: () {
                  var now = DateTime.now();
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  }
                },
                text: 'Post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://scontent.fcai20-6.fna.fbcdn.net/v/t39.30808-6/241641205_3055483858105537_6764052790531636153_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=4Jioe19flcIAX_DWo_x&_nc_ht=scontent.fcai20-6.fna&oh=00_AT888gPa_LILJcbbwXsMjlczawZI99tHq5Elxo-pbUuV8w&oe=62A0410C',
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        userModel!.name,
                        style: const TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            4.0,
                          ),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
