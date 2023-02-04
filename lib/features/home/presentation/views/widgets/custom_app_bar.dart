import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_routers.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40,bottom: 20),
      child: Row(
        children: [
          //Image.asset(ImageAssets.solidCircleIc,height: 18,),
          const Spacer(),
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(Routes.searchRoute);
            },
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
