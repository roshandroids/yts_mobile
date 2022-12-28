import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:yts_mobile/core/core.dart';

extension SnackbarExtension on BuildContext {
  Future<bool> showSnackbar(String message, {bool isError = false}) async {
    await Flushbar<void>(
      icon: Icon(
        isError
            ? Icons.error_outline_rounded
            : Icons.check_circle_outline_rounded,
        color: isError ? Theme.of(this).coreRed : Theme.of(this).coreGreen,
      ),
      messageText: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(this)
            .textTheme
            .bodyText2
            ?.copyWith(color: Theme.of(this).coreBlack),
      ),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(seconds: 1, milliseconds: 300),
      backgroundColor: Theme.of(this).coreWhite,
      leftBarIndicatorColor:
          isError ? Theme.of(this).coreRed : Theme.of(this).coreGreen,
    ).show(this);
    return true;
  }
}
