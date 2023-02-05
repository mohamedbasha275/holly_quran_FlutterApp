import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/styles_manager.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/azkar/data/models/azkar_model.dart';

class AzkarWidget extends StatefulWidget {
  final AzkarModel azkar;

  const AzkarWidget({required this.azkar, Key? key}) : super(key: key);

  @override
  State<AzkarWidget> createState() => _AzkarWidgetState();
}

class _AzkarWidgetState extends State<AzkarWidget> {
  int azkarCount = 1;
  Color color = AppColors.primary;
  @override
  void initState() {
    azkarCount = widget.azkar.count;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            children: [
              TextButton(
                onPressed: azkarCount > 0 ? (){
                  setState(() {
                    azkarCount -=1;
                    if(azkarCount == 0){
                      color = AppColors.secondary;
                    }
                  });
                }:null,
                child: Container(
                  width: AppSize.s80,
                  height: AppSize.s200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                  child: Text(
                    "$azkarCount",
                    style: getBoldStyle(color: AppColors.white, fontSize: AppSize.s28),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSize.s8,
              ),
              Expanded(
                child: Text(widget.azkar.content,
                    style: Theme.of(context).textTheme.headlineLarge),
              )
            ],
          ),
        ),
      ),
    );
  }
}
