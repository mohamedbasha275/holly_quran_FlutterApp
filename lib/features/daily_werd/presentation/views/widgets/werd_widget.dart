import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/daily_werd/data/models/werd.dart';
import 'package:holly_quran/features/daily_werd/presentation/view_models/werd_cubit.dart';
import 'package:holly_quran/features/home/presentation/view_models/sadaqat/sadaqat_cubit.dart';

class WerdWidget extends StatelessWidget {
  final WerdModel werd;
  final int index;

  const WerdWidget({required this.werd, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.width * 0.75,
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSize.s10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: AppSize.s1,
                    color: AppColors.grey,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    werd.title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: context.width * 0.15,
            child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    await BlocProvider.of<WerdCubit>(context)
                        .removeOneWerd(index: index);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  child: CircleAvatar(
                    backgroundColor: AppColors.reset,
                    child: Icon(Icons.delete_forever,color: AppColors.white,),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await BlocProvider.of<WerdCubit>(context)
                        .updateWerd(index: index);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  child: CircleAvatar(
                    backgroundColor:
                        werd.done ? AppColors.green : AppColors.grey,
                    child: Icon(
                      Icons.check_circle,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
