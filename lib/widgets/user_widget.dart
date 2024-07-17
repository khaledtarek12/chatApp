import 'package:flutter/material.dart';

import '../models/user.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(user.photo),
                ),
                borderRadius: BorderRadius.circular(150)),
          ),
          const SizedBox(width: 10),
          Text(
            user.name,
            style:
                const TextStyle(color: Colors.black, fontSize: 25, height: 1),
          ),
        ],
      ),
    );
  }
}
