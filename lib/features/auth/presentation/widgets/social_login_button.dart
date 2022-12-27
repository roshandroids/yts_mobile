import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:yts_mobile/core/core.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.asset,
    this.onTap,
    this.height,
    this.width,
  });
  final String asset;
  final VoidCallback? onTap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      splashColor: Theme.of(context).coreTransparent,
      focusColor: Theme.of(context).coreTransparent,
      highlightColor: Theme.of(context).coreTransparent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(4),
        child: SvgPicture.asset(
          asset,
          height: height ?? 35,
          width: width ?? 35,
        ),
      ),
    );
  }
}
