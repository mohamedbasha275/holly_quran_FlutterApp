import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_routers.dart';

class QuranAppBar extends StatelessWidget {
  final String title;

  const QuranAppBar({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Image.asset(ImageAssets.arrow, width: 30),
          ),
          SizedBox(
            width: context.width * 0.6,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {
              GoRouter.of(context).pushReplacement(Routes.homeRoute);
            },
            icon: Image.asset(ImageAssets.home, width: 35),
          ),
        ],
      ),
    );
  }
}
