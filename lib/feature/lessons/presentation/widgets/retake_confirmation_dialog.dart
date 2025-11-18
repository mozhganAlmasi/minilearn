import 'package:flutter/material.dart';

Future<bool> showRetakeConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false, // کاربر حتما باید یکی از دکمه‌ها را بزند
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.limeAccent,
        title: Text(
          'Confirm Retake',

        ),
        content: Text(
          'This will delete your current quiz results. Are you sure you want to continue?',

        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300],
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancel',

            ),
            onPressed: () {
              Navigator.of(context).pop(false); // لغو شد
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Confirm',

            ),
            onPressed: () {
              Navigator.of(context).pop(true); // تایید شد
            },
          ),
        ],
      );
    },
  ).then((value) => value ?? false); // اگر کاربر دیالوگ را بست، false برگردان
}
