import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/core/di/injection_container.dart';
import 'package:travelapp/features/social/presentation/cubit/social_cubit.dart';
import 'package:travelapp/features/social/presentation/cubit/social_state.dart';
import 'package:travelapp/widgets/components.dart' as components;
import 'package:travelapp/widgets/custom_text_field.dart';

/// Page for editing user profile
class EditProfilePage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/edit-profile';

  /// Creates a new [EditProfilePage] instance
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController =
      TextEditingController(text: 'User Name');
  final TextEditingController _bioController =
      TextEditingController(text: 'Travel enthusiast | Egypt explorer');
  final TextEditingController _phoneController =
      TextEditingController(text: '+20 123 456 7890');
  final TextEditingController _emailController =
      TextEditingController(text: 'user@example.com');
  File? _profileImage;
  File? _coverImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _getProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _getCoverImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _coverImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SocialCubit>(),
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          if (state is SocialPostUploaded) {
            components.showToast(
              text: 'Profile updated successfully',
              state: components.ToastStates.SUCCESS,
            );
            Navigator.pop(context);
          } else if (state is SocialError) {
            components.showToast(
              text: state.message,
              state: components.ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              title: Text(
                'Edit Profile',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // TODO: Implement profile update functionality
                    components.showToast(
                      text: 'Profile update not implemented yet',
                      state: components.ToastStates.ERROR,
                    );
                  },
                  child: Text(
                    'UPDATE',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (state is SocialLoading) const LinearProgressIndicator(),
                    const SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            image: DecorationImage(
                              image: _coverImage != null
                                  ? FileImage(_coverImage!) as ImageProvider
                                  : const AssetImage('assets/images/night.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                            radius: 20,
                            backgroundColor: KprimaryColor,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _getCoverImage,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!) as ImageProvider
                              : const AssetImage('assets/images/splash.png'),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                            radius: 20,
                            backgroundColor: KprimaryColor,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _getProfileImage,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: _nameController,
                      label: 'Name',
                      hint: 'Enter your name',
                      suffixIcon: const Icon(Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _bioController,
                      label: 'Bio',
                      hint: 'Enter your bio',
                      suffixIcon: const Icon(Icons.info),
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _phoneController,
                      label: 'Phone',
                      hint: 'Enter your phone number',
                      suffixIcon: const Icon(Icons.phone),
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'Enter your email address',
                      suffixIcon: const Icon(Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
