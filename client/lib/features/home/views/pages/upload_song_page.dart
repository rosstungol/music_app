import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils.dart';
import '../../../../core/widgets/custom_field.dart';
import '../repositories/home_repository.dart';
import '../widgets/audio_wave.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final artistController = TextEditingController();
  final songNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(
        () {
          selectedImage = pickedImage;
        },
      );
    }
  }

  void selectAudio() async {
    final pickedAudio = await pickAudio();

    if (pickedAudio != null) {
      setState(
        () {
          selectedAudio = pickedAudio;
        },
      );
    }
  }

  @override
  void dispose() {
    artistController.dispose();
    songNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Upload Song'),
        actions: [
          IconButton(
            onPressed: () async {
              await HomeRepository().uploadSong(
                selectedImage!,
                selectedAudio!,
              );
            },
            icon: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: selectedImage != null
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : DottedBorder(
                        color: Pallete.borderColor,
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Select the thumbnail for your song',
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 40),
              selectedAudio != null
                  ? AudioWave(path: selectedAudio!.path)
                  : CustomField(
                      hintText: 'Pick Song',
                      controller: null,
                      readOnly: true,
                      onTap: selectAudio,
                    ),
              const SizedBox(height: 20),
              CustomField(
                hintText: 'Artist',
                controller: artistController,
              ),
              const SizedBox(height: 20),
              CustomField(
                hintText: 'Song Name',
                controller: songNameController,
              ),
              const SizedBox(height: 20),
              ColorPicker(
                pickersEnabled: const {
                  ColorPickerType.wheel: true,
                },
                color: selectedColor,
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
