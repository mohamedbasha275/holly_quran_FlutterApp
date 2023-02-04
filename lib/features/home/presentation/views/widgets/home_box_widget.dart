import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

class HomeBoxWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String route;
  const HomeBoxWidget({required this.title,required this.imagePath,required this.route,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        GoRouter.of(context).push(route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p6),
          child: Row(
            children: [
              Image.asset(imagePath),
              Text(title,style: Theme.of(context).textTheme.headlineLarge,),
            ],
          ),
        ),
      ),
    );
  }
}
