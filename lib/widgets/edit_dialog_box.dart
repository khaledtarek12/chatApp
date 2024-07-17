import 'package:flutter/material.dart';

import '../constants.dart';

void editDialogBox(
    {required BuildContext context,
    required String initialMessage,
    required String text,
    required int index,
    required String itemId,
    required VoidCallback onTap}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit Message',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
            ),
          ),
          content: TextFormField(
            validator: (data) {
              if (data!.isEmpty) {
                return 'Field is empty';
              }
              return null;
            },
            onChanged: (data) {
              text = data;
            },
            initialValue: initialMessage,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.white),
                gapPadding: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.white),
                gapPadding: 20,
              ),
              contentPadding: EdgeInsets.all(20),
              suffixIcon: Icon(Icons.edit_rounded),
              suffixIconColor: Colors.white,
            ),
          ),
          backgroundColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          actionsPadding: const EdgeInsets.only(top: 10, right: 10, bottom: 20),
          actions: [
            GestureDetector(
              onTap: () async {
                onTap();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Edit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      });
}
