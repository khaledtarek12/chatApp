// ignore_for_file: depend_on_referenced_packages

import 'package:khaled/constants.dart';
import 'package:khaled/cubits/chat_cubit/chat_cubit.dart';
import 'package:khaled/helper/shared_preferences.dart';
import 'package:khaled/models/screen_args.dart';
import 'package:khaled/models/user.dart';
import 'package:khaled/screens/chat_screen.dart';
import 'package:khaled/screens/setting_screen.dart';
import 'package:khaled/widgets/confirm_dialog_box.dart';
import 'package:khaled/widgets/user_widget.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils.dart';

class PeopleScreen extends StatelessWidget {
  PeopleScreen({super.key});

  static String id = 'PeopleScreen';

  final CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollection);

  final CacheData cacheData = CacheData();

  @override
  Widget build(BuildContext context) {
    String userEmail = ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> usersList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              usersList.add(User.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: Container(
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45.withOpacity(0.2),
                        // offset: const Offset(
                        //   0.0,
                        //   10.0,
                        // ),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                    onPressed: () {
                      confirmDialogBox(
                          context: context,
                          onTap: () {
                            cacheData.removeEmail();
                            // cacheData.removePassword();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          title: "Logout",
                          body: 'Are you sure want logout?',
                          no: 'Cancel',
                          confirm: 'Logout');
                      // Navigator.pop(context);
                    },
                    // padding: const EdgeInsets.all(20),
                    icon: Transform.scale(
                      scaleX: -1,
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        // color: Colors.black,
                        size: 30,
                      ),
                    )),
              ),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  PopupMenuButton(
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ),
                      ),
                      iconSize: 35,
                      onSelected: (value) {
                        switch (value) {
                          case MenuItem.search:
                            {}
                            break;
                          case MenuItem.setting:
                            Navigator.pushNamed(context, SettingScreen.id,
                                arguments: userEmail);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                            const PopupMenuItem(
                                value: MenuItem.search,
                                child: ListTile(
                                  title: Text('Search'),
                                  leading: Icon(Icons.search_rounded),
                                )),
                            const PopupMenuItem(
                                value: MenuItem.setting,
                                child: ListTile(
                                  title: Text('Setting'),
                                  leading: Icon(Icons.settings_rounded),
                                )),
                          ])
                ],
                toolbarHeight: 120,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                image: NetworkImage(
                                    findUserPhoto(usersList, userEmail)),
                              ),
                              borderRadius: BorderRadius.circular(200)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              findUserName(usersList, userEmail),
                              style: const TextStyle(
                                  color: Colors.black,
                                  height: 1.5,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(findUserStatues(usersList, userEmail),
                                style: const TextStyle(
                                  color: Colors.black,
                                  height: 1.5,
                                  fontSize: 18,
                                ))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Chats',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black45.withOpacity(0.2),
                        //     offset: const Offset(
                        //       0.0,
                        //       10.0,
                        //     ),
                        //     blurRadius: 15.0,
                        //     spreadRadius: 5.0,
                        //   ),
                        // ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: usersList.length,
                              itemBuilder: (context, index) {
                                return MaterialButton(
                                  onPressed: () {
                                    BlocProvider.of<ChatCubit>(context)
                                        .getMessages(
                                            context: context,
                                            userEmail: userEmail,
                                            friendEmail:
                                                usersList[index].email);
                                    Navigator.pushNamed(
                                      context,
                                      ChatScreen.id,
                                      arguments: ScreenArgs(
                                          userEmail: userEmail,
                                          friendName: usersList[index].name,
                                          friendEmail: usersList[index].email,
                                          friendPhoto: usersList[index].photo),
                                    );
                                  },
                                  child: UserWidget(user: usersList[index]),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Loading Chats'),
              ),
            );
          }
        });
  }
}

// void uploadImage() {
//   FirebaseStorage storage =
//       FirebaseStorage.instanceFor(bucket: 'gs://chaty-666cb.appspot.com/');
//   StroageReference ref = storage.ref().child(p.basename(image.path));
// }

enum MenuItem {
  search,
  setting,
}
