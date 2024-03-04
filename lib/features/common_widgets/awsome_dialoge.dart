import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

class AppAwesomeDialog extends StatelessWidget {
  final TextEditingController controller;
  final controller2;
  final String title;
  final Function function;

  const AppAwesomeDialog({required this.controller, required this.function, Key? key, required this.title,
    this.controller2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s160,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            AppColors.primary,
          )
        ),
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
                   Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppSize.s10),
                  SizedBox(
                    width: context.width * 0.7,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: AppStrings.name2,
                        ),
                        controller: controller,
                      ),
                    ),
                  ),
                  if(controller2 != null)
                    const SizedBox(height: AppSize.s10),
                  if(controller2 != null)
                  SizedBox(
                    width: context.width * 0.7,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'العدد',
                        ),
                        controller: controller2,
                        keyboardType: TextInputType.number,
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
            Text(AppStrings.addNew, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: AppSize.s10),
            Icon(Icons.add_circle,color: AppColors.white,),
          ],
        ),
      ),
    );
  }
}
