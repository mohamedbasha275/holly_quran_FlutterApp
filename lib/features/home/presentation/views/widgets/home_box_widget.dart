import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// class HomeBoxWidget extends StatelessWidget {
//   final String title;
//   final String imagePath;
//   final String route;
//
//   const HomeBoxWidget(
//       {required this.title,
//       required this.imagePath,
//       required this.route,
//       Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         GoRouter.of(context).push(route);
//       },
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(AppColors.secondary),
//       ),
//       child: Row(
//         children: [
//           Image.asset(imagePath, width: AppSize.s40),
//           const SizedBox(width: AppSize.s4),
//           Text(title,
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineLarge!
//                   .copyWith(fontSize: FontSize.s16)),
//         ],
//       ),
//     );
//   }
// }

class HomeBoxWidget2 extends StatelessWidget {
  final String title;
  final String imagePath;
  final String route;
  final String type;

  const HomeBoxWidget2(
      {required this.title,
      required this.imagePath,
      required this.route,
      this.type = 'screen',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (type == 'share') {
          Share.share(
              "${AppConstants.googlePlayUrl} ${AppStrings.inviteShareApp} ");
        } else if (type == 'url') {
          launchUrl(
            Uri.parse(AppConstants.googlePlayUrl),
            mode: LaunchMode.externalApplication,
          );
        } else {
          GoRouter.of(context).push(route);
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.secondary),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(
          children: [
            Image.asset(imagePath, width: AppSize.s40),
            const SizedBox(height: AppSize.s5),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: FontSize.s14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
