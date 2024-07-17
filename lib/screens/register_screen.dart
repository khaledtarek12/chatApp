// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:khaled/cubits/register_cubit/register_cubit.dart';
import 'package:khaled/cubits/select_image_cubit/select_image_cubit.dart';
import 'package:khaled/screens/people_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  static String id = 'RegisterScreen';

  String? name, email, password, confirmPassword, statues;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  RegisterScreen({super.key});

  // File? _image;
  // String? imageUrl;

  // void selectImage({required BuildContext context}) async {
  //   try {
  //     //select image from device
  //     ImagePicker imagePicker = ImagePicker();
  //     XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

  //     if (file == null) return;

  //     _image = File(file.path);

  //     //upload to firebase
  //     final String uniqueFileName =
  //         DateTime.now().millisecondsSinceEpoch.toString();

  //     final Reference referenceRoot = FirebaseStorage.instance.ref();
  //     final referenceDirImages = referenceRoot.child('images');
  //     final referenceImageToUpload = referenceDirImages.child(uniqueFileName);

  //     try {
  //       await referenceImageToUpload.putFile(File(file.path));
  //       imageUrl = await referenceImageToUpload.getDownloadURL();
  //       print('Image uploaded!');
  //     } catch (error) {
  //       print('Image not uploaded');
  //     }
  //   } catch (ex) {
  //     showSnackBar(
  //         context: context,
  //         text: 'No image selected',
  //         icon: Icons.image_not_supported_rounded,
  //         backColor: Colors.blueGrey);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccsessState) {
          showSnackBar(
            context: context,
            text: 'Register Success',
            icon: Icons.check_circle,
            backColor: Colors.green,
          );
          Future.delayed(const Duration(seconds: 1), () {
            // BlocProvider.of<ChatCubit>(context)
            //     .getMessages(context: context, userEmail: email!);
            Navigator.pushNamed(context, PeopleScreen.id, arguments: email);
          });
          isLoading = false;
        } else if (state is RegisterNotSamePasswordState) {
          showSnackBar(
            context: context,
            text: 'Password does\'t match',
            icon: Icons.no_encryption_gmailerrorred_rounded,
            backColor: Colors.red,
          );
          isLoading = false;
        } else if (state is RegisterFailureState) {
          showSnackBar(
            context: context,
            text: state.errMessage,
            icon: Icons.no_encryption_gmailerrorred,
            backColor: Colors.red,
          );
          isLoading = false;
        }
      },
      builder: (context, state) {
        return BlocConsumer<SelectImageCubit, SelectImageState>(
          listener: (context, state) {
            if (state is SelectImageUploadSucsess) {
              print('sucsess');
            } else if (state is SelectImageUploadFailure) {
              showSnackBar(
                context: context,
                text: state.errMessage,
                icon: Icons.image_not_supported_rounded,
                backColor: Colors.blueGrey,
              );
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Scaffold(
                appBar: AppBar(backgroundColor: kPrimaryColor, elevation: 0),
                backgroundColor: kPrimaryColor,
                body: Container(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                BlocProvider.of<SelectImageCubit>(context)
                                            .imageFile ==
                                        null
                                    ? GestureDetector(
                                        onTap: () async {
                                          BlocProvider.of<SelectImageCubit>(
                                                  context)
                                              .selectImage(context: context);
                                        },
                                        child: const CircleAvatar(
                                          radius: 65,
                                          backgroundImage: AssetImage(
                                              'assets/images/user.png'),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<SelectImageCubit>(
                                                  context)
                                              .selectImage(context: context);
                                        },
                                        child: CircleAvatar(
                                          radius: 65,
                                          backgroundImage: FileImage(
                                              BlocProvider.of<SelectImageCubit>(
                                                      context)
                                                  .imageFile as File),
                                        ),
                                      ),
                                Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: IconButton(
                                    onPressed: () async {
                                      BlocProvider.of<SelectImageCubit>(context)
                                          .selectImage(context: context);
                                    },
                                    icon: const Icon(Icons.add_a_photo_rounded,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            FormTextFieldWidget(
                              onChanged: (data) {
                                name = data;
                              },
                              hintText: 'Full name',
                              isPassword: false,
                              icon: const Icon(
                                  Icons.drive_file_rename_outline_rounded),
                            ),
                            const SizedBox(height: 16),
                            FormTextFieldWidget(
                              hintText: 'Email',
                              isPassword: false,
                              icon: const Icon(Icons.alternate_email_rounded),
                              onChanged: (data) {
                                email = data;
                              },
                            ),
                            const SizedBox(height: 16),
                            FormTextFieldWidget(
                              hintText: 'Password',
                              isPassword: true,
                              icon: const Icon(Icons.password_rounded),
                              onChanged: (data) {
                                password = data;
                              },
                            ),
                            const SizedBox(height: 16),
                            FormTextFieldWidget(
                              hintText: 'Confirm your password',
                              isPassword: true,
                              icon: const Icon(Icons.password_rounded),
                              onChanged: (String data) {
                                confirmPassword = data;
                              },
                            ),
                            const SizedBox(height: 16),
                            FormTextFieldWidget(
                              hintText: 'Ex: At work',
                              icon: const Icon(Icons.text_fields_rounded),
                              isPassword: false,
                              onChanged: (String data) {
                                statues = data;
                              },
                            ),
                            ButtonWidget(
                                text: 'Register',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<RegisterCubit>(context)
                                        .registerUser(
                                      context: context,
                                      name: name!,
                                      email: email!,
                                      password: password!,
                                      confirmPassword: confirmPassword!,
                                      statues: statues!,
                                      imageUrl:
                                          BlocProvider.of<SelectImageCubit>(
                                                      context)
                                                  .imageUrl ??
                                              'https://t.ly/DSYXw',
                                    );
                                  }
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('already have an account? '),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
