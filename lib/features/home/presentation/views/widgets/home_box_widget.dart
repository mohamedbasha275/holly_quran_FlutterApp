import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

class HomeBoxWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String route;
  const HomeBoxWidget({required this.title,required this.imagePath,required this.route,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        GoRouter.of(context).push(route);
      },
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.secondary),),
      child: Row(
        children: [
          Image.asset(imagePath,width: AppSize.s40),
          const SizedBox(width: AppSize.s4),
          Text(title,style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: FontSize.s16
          )),
        ],
      ),
    );
  }
}
