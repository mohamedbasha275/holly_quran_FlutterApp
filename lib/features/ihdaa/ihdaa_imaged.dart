import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';

class IhdaaImage extends StatelessWidget {
  final String name;
  final String content;
  final Uint8List signature;
  final bool isGeneral;
  const IhdaaImage({Key? key,required this.name,required this.content,
    required this.signature,required this.isGeneral}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s50),
          child: MyAppBar(title: AppStrings.ihdaa),
        ),
        body: Container(
          height: context.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(isGeneral ? ImageAssets.generalIhdaa : ImageAssets.ramadanIhdaa),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        color: AppColors.black45,
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Text('إهداء إلي : $name',
                        style: Theme.of(context).textTheme
                            .headlineMedium!.copyWith(
                          fontSize: FontSize.s25
                        ),),
                      ),
                      SizedBox(height: context.height * 0.15,),
                      Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        color: AppColors.black45,
                        child: Text(content,
                          style: Theme.of(context).textTheme
                              .headlineMedium!.copyWith(
                              fontSize: FontSize.s25
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                    ),
                    width: AppSize.s150,
                    height: AppSize.s150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                        child: Image.memory(signature,)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
