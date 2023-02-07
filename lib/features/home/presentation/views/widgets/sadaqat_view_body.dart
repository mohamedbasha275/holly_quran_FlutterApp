import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/awsome_dialoge.dart';
import 'package:holly_quran/features/common_widgets/show_snackBar.dart';
import 'package:holly_quran/features/common_widgets/state_renderer/state_render.dart';
import 'package:holly_quran/features/home/presentation/view_models/sadaqat/sadaqat_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/sadaqat_widget.dart';

class SadaqatViewBody extends StatelessWidget {
  const SadaqatViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Container(
      height: context.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: AppSize.s20),
              Image.asset(ImageAssets.sadaqatLogo, width: AppSize.s100),
              Text(
                AppStrings.sadaqatTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              AppAwesomeDialog(controller: nameController),
              const Text(
                AppStrings.sadaqatSubTitle,
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<SadaqatCubit, SadaqatState>(
                builder: (context, state) {
                  if (state is SadaqatSuccess) {
                    return SizedBox(
                      height: AppSize.s420,
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(AppPadding.p8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 10 / 2,
                          ),
                          //itemCount: state.sours.length,
                          itemCount: state.sadaqat.length,
                          itemBuilder: (context, index) => SadaqatWidget(
                            title: state.sadaqat[index],
                            index: index,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return StateRender.fullLoadingScreenImage;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
