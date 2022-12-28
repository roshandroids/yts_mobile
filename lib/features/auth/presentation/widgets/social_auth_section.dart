import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/auth/auth.dart';

class SocialAuthSection extends ConsumerWidget {
  const SocialAuthSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialAuthState = ref.watch(socialLoginControllerProvider);
    ref.listen(
      socialLoginControllerProvider,
      (oldState, newState) {
        if (newState is BaseError) {
          context.showSnackbar(newState.failure.reason, isError: true);
        }
        if (newState is BaseSuccess<UserModel>) {
          context
              .showSnackbar('Welcome ${newState.data?.email}')
              .then((value) => context.go(RoutePaths.latestMovies.path));
        }
      },
    );
    return AbsorbPointer(
      absorbing: socialAuthState is BaseLoading,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              ref
                  .read(socialLoginControllerProvider.notifier)
                  .loginWithSocialAuth(
                    socialAuthType: SocialAuthType.facebook,
                  );
            },
            child: const SocialLoginButton(
              asset: AppAssets.facebookLogo,
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              ref
                  .read(socialLoginControllerProvider.notifier)
                  .loginWithSocialAuth(
                    socialAuthType: SocialAuthType.google,
                  );
            },
            child: const SocialLoginButton(asset: AppAssets.googleLogo),
          ),
        ],
      ),
    );
  }
}
