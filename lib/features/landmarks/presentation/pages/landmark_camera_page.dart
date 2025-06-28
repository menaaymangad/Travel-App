import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../cubit/landmark_camera_cubit.dart';
import '../cubit/landmark_camera_state.dart';
import 'package:travelapp/core/di/injection_container.dart';

class LandmarkCameraPage extends StatefulWidget {
  const LandmarkCameraPage({Key? key}) : super(key: key);

  @override
  State<LandmarkCameraPage> createState() => _LandmarkCameraPageState();
}

class _LandmarkCameraPageState extends State<LandmarkCameraPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _recognizedLandmark;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LandmarkCameraCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Landmark Camera Search')),
        body: BlocConsumer<LandmarkCameraCubit, LandmarkCameraState>(
          listener: (context, state) {
            if (state is LandmarkCameraRecognized) {
              setState(() => _recognizedLandmark = state.landmark);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (_image != null) Image.file(_image!, height: 200),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Pick Image'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _image == null
                        ? null
                        : () {
                            context
                                .read<LandmarkCameraCubit>()
                                .recognizeLandmark(_image!.path);
                          },
                    child: const Text('Recognize Landmark'),
                  ),
                  const SizedBox(height: 16),
                  if (state is LandmarkCameraLoading)
                    const CircularProgressIndicator(),
                  if (_recognizedLandmark != null)
                    Column(
                      children: [
                        Text('Recognized: $_recognizedLandmark',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<LandmarkCameraCubit>()
                                .speakText(_recognizedLandmark!);
                          },
                          child: const Text('Speak Description'),
                        ),
                      ],
                    ),
                  if (state is LandmarkCameraError)
                    Text(state.message,
                        style: const TextStyle(color: Colors.red)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
