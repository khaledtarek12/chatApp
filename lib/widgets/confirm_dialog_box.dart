import 'package:khaled/constants.dart';
import 'package:flutter/material.dart';

void confirmDialogBox(
    {required BuildContext context,
    required VoidCallback onTap,
    required String title,
    required String body,
    required String no,
    required String confirm}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
            ),
          ),
          content: Text(
            body,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          actionsPadding: const EdgeInsets.only(top: 10, right: 10, bottom: 20),
          actions: [
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  confirm,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                  no,
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
