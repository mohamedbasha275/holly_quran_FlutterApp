import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/show_snackBar.dart';
import 'package:holly_quran/features/home/presentation/view_models/sadaqat/sadaqat_cubit.dart';

class AppAwesomeDialog extends StatelessWidget {
  final TextEditingController controller;
  final Function function;

  const AppAwesomeDialog(
      {required this.controller, required this.function, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s150,
      child: ElevatedButton(
        onPressed: () {
          AwesomeDialog(
            context: context,
            //animType: AnimType.rightSlide,
            dialogType: DialogType.question,
            btnOkColor: AppColors.primary,
            btnOkText: AppStrings.save,
            body: Center(
              child: Column(
                children: [
                  const Text(
                    AppStrings.sadaqaName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppSize.s10),
                  SizedBox(
                    width: context.width * 0.7,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: AppStrings.name,
                        ),
                        controller: controller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            btnOkOnPress: () {
              if (controller.text != '') {
                function();
              }
            },
          ).show();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppStrings.addNew,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: AppSize.s10),
            const Icon(Icons.add_circle),
          ],
        ),
      ),
    );
  }
}
