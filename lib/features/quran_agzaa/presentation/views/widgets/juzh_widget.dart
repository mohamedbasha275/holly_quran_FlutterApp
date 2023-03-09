import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/quran_agzaa/data/models/juzh_model.dart';

class JuzhWidget extends StatelessWidget {
  final JuzhModel juzh;

  const JuzhWidget({required this.juzh, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).pushNamed(Routes.juzhDetailsRoute,
            params: {'id1': "${juzh.startPage}",
              'id2': '${juzh.endPage}'});
      },
      child: Container(
        margin: const EdgeInsets.only(top: AppMargin.m8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: AppSize.s50,
                      height: AppSize.s50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageAssets.star),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Text(
                        arNumber("${juzh.id}"),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: FontSize.s16),
                      ),
                    ),
                    const SizedBox(width: AppSize.s10),
                    Text(
                      juzh.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
