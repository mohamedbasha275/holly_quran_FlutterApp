import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/presentation/view_models/sadaqat/sadaqat_cubit.dart';
import 'package:quran/quran.dart' as quran;

class SadaqatWidget extends StatelessWidget {
  final String title;
  final int index;
  const SadaqatWidget({required this.title,required this.index,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.width * 0.75,
            child: ElevatedButton(
              onPressed: () {
                Random random = Random();
                //int quranPageCount = quran.totalPagesCount;
                int quranPageCount = 604;
                int randomPageNumber = random.nextInt(quranPageCount) + 1; // ad 1 to ignore 0
               // GoRouter.of(context).push(Routes.sadaqaSurahViewRoute,extra: title);
                GoRouter.of(context).pushNamed(Routes.sadaqaSurahViewRoute,
                    params: {'id1': title, 'id2': '$randomPageNumber'});
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.all(AppPadding.p8)),
                backgroundColor: MaterialStateProperty.all(AppColors.white),
              ),
              child: Column(
                children: [
                  Text(title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: context.width * 0.15,
            child: ElevatedButton(
              onPressed: () async{
                await BlocProvider.of<SadaqatCubit>(context).removeOneSadaqa(index: index);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.all(AppPadding.p8)),
                backgroundColor: MaterialStateProperty.all(AppColors.reset),
              ),
              child: Container(
                width: AppSize.s40,
                height: AppSize.s40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Icon(Icons.delete_forever,color: AppColors.white,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
