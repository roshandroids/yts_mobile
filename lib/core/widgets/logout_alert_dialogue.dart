import 'package:flutter/material.dart';
import 'package:yts_mobile/core/core.dart';

class LogoutAlertDialogue {
  static Future<bool?> showAlert(
    BuildContext context,
  ) async {
    return showDialog<bool?>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        title: Text('Logout ?'.hardcoded),
        content: const Text(''),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('Confirm'.hardcoded),
            onPressed: () => Navigator.pop(context, true),
          ),
          TextButton(
            child: Text('Cancel'.hardcoded),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }
}
