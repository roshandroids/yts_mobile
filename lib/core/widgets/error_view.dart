import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yts_mobile/core/core.dart';

/// Default error view widget
class ErrorView extends StatelessWidget {
  /// Creates a new instance of [ErrorView]
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(AppAssets.errorAnimation),
    );
  }
}
