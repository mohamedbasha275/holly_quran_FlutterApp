import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_routers.dart';

class SouraStackWidget extends StatelessWidget {
  final VoidCallback functionMark;
  const SouraStackWidget({Key? key, required this.functionMark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pushReplacementNamed(Routes.homeRoute);
            },
            icon: Image.asset(ImageAssets.home,width: 35,),
          ),
          SizedBox(
            width: context.width * 0.6,
            child: IconButton(
              onPressed: functionMark,
              icon: Image.asset(ImageAssets.dayWheelMark,width: 35,),
            ),
          ),
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
