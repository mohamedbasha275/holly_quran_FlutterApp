import 'dart:ui';

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
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: werd.done ? AppColors.green : AppColors.grey,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
            ),
            child: TextButton(
              onPressed: () async {
                await BlocProvider.of<WerdCubit>(context)
                    .updateWerd(index: index);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: werd.done ? AppColors.green : AppColors.grey,
                  borderRadius: const BorderRadius.only(),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: context.width * 0.55,
            child: Container(
              padding: const EdgeInsets.all(12.5),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.5),
                borderRadius: const BorderRadius.only(),
                // boxShadow: <BoxShadow>[
                //   BoxShadow(
                //     blurRadius: AppSize.s1,
                //     color: AppColors.grey,
                //   ),
                // ],
              ),
              child: Text(
                werd.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.reset,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6)),
            ),
            child: TextButton(
              onPressed: () async {
                await BlocProvider.of<WerdCubit>(context)
                    .removeOneWerd(index: index);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.reset,
                  borderRadius: const BorderRadius.only(),
                ),
                child: Icon(
                  Icons.delete_forever,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
