import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/feature/splash/cubit/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().navigateToNextScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background leaves decoration - slow slide and fade in from left
          FadeInLeft(
            duration: const Duration(milliseconds: 2000),
            child: CustomImage(Assets.icons.splashLogo),
          ),
          
          // Background texture - slow fade in
          FadeIn(
            duration: const Duration(milliseconds: 1800),
            child: CustomImage(Assets.images.splashBackground.path),
          ),

          // Main Center Logo - slow, smooth ZoomIn with delay
          Center(
            child: ZoomIn(
              duration: const Duration(milliseconds: 2000),
              delay: const Duration(milliseconds: 500),
              child: CustomImage(
                Assets.icons.thimarLogo,
                width: 180.w,
                height: 180.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
