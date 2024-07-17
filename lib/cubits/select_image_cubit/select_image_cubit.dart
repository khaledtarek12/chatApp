// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
part 'select_image_state.dart';

class SelectImageCubit extends Cubit<SelectImageState> {
  SelectImageCubit() : super(SelectImageInitialState());

  String? imageUrl;
  File? imageFile;

  Future<void> selectImage({required BuildContext context}) async {
    try {
      //select image from device
      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

      if (file == null) return;
      imageFile = (File(file.path));

      //upload to firebase
      final String uniqueFileName =
          DateTime.now().millisecondsSinceEpoch.toString();

      final Reference referenceRoot = FirebaseStorage.instance.ref();
      final referenceDirImages = referenceRoot.child('images');
      final referenceImageToUpload = referenceDirImages.child(uniqueFileName);

      try {
        await referenceImageToUpload.putFile(File(file.path));
        imageUrl = await referenceImageToUpload.getDownloadURL();
        emit(SelectImageUploadSucsess());
      } catch (error) {
        //Image not uploaded
        emit(SelectImageUploadFailure(errMessage: 'Error while uploading image, Try again'));
      }
    } catch (ex) {
      emit(SelectImageUploadFailure(errMessage: 'No image selected, Try again'));
    }
  }
}
