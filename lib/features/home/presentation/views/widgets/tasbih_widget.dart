import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/tasbih/tasbih_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/tasbeh/tasbeh_cubit.dart';

class TasbihWidget extends StatelessWidget {
  final TasbihModel tasbih;

  const TasbihWidget({required this.tasbih, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController counterController = TextEditingController();
    nameController.text = tasbih.name;
    counterController.text = tasbih.counter.toString();
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.width * 0.8,
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(Routes.tasbihViewItem,
                    params: {'id1': tasbih.name, 'id2': '${tasbih.counter}'});
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.all(AppPadding.p12)),
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primarySwatch),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              child: Column(
                children: [
                  Text(
                    tasbih.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    'العدد : ${tasbih.counter}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 14,
                      fontFamily: FontConstants.fontFamily,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!tasbih.static)
            _buildPopupMenu(context, nameController, counterController),
        ],
      ),
    );
  }

  Widget _buildPopupMenu(
      BuildContext context, nameController, counterController) {
    return PopupMenuButton<String>(
      onSelected: (String value) async {
        if (value == 'Edit') {
          return AwesomeDialog(
            context: context,
            //animType: AnimType.rightSlide,
            dialogType: DialogType.question,
            btnOkColor: AppColors.primary,
            btnOkText: AppStrings.save,
            body: Center(
              child: Column(
                children: [
                  Text(
                    'تعديل',
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
                        controller: nameController,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s10),
                  SizedBox(
                    width: context.width * 0.7,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'العدد',
                        ),
                        controller: counterController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            btnOkOnPress: () {
              if (nameController.text != '' && counterController.text != '') {
                BlocProvider.of<TasbehCubit>(context).updateTasbih(
                  id: tasbih.id,
                  name: nameController.text,
                  counter: int.parse(
                    counterController.text,
                  ),
                );
              }
            },
          ).show();
        } else if (value == 'Delete') {
          await BlocProvider.of<TasbehCubit>(context)
              .removeOneTasbih(tasbihId: tasbih.id);
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'Edit',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'تعديل',
                  style: TextStyle(
                      fontSize: 16, fontFamily: FontConstants.fontFamily),
                ),
                Icon(Icons.edit_note),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'Delete',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'حذف',
                  style: TextStyle(
                      fontSize: 16, fontFamily: FontConstants.fontFamily),
                ),
                Icon(Icons.delete),
              ],
            ),
          ),
        ];
      },
    );
  }
}
