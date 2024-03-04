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
import 'package:holly_quran/features/daily_werd/presentation/view_models/werd_cubit.dart';
import 'package:holly_quran/features/daily_werd/presentation/views/widgets/werd_widget.dart';

class WerdViewBody extends StatelessWidget {
  const WerdViewBody({Key? key}) : super(key: key);

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
              Image.asset(ImageAssets.werd, width: AppSize.s100),
              Text(
                AppStrings.werdTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              AppAwesomeDialog(
                controller: nameController,
                title: 'إضافة ورد',
                function: () {
                  BlocProvider.of<WerdCubit>(context)
                      .addOneWerd(name: nameController.text)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      buildSnackBar(
                        context,
                        title: AppStrings.werdSaved,
                        background: AppColors.primary,
                      ),
                    );
                    nameController.text = '';
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  await BlocProvider.of<WerdCubit>(context).updateAllWerd();
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                child: Container(
                  width: AppSize.s150,
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                      color: AppColors.reset,
                    borderRadius: BorderRadius.circular(AppSize.s10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(AppStrings.tasbihReset,
                      style: Theme.of(context).textTheme.titleSmall),
                      Icon(
                        Icons.rotate_left_outlined,
                        color: AppColors.white,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              BlocBuilder<WerdCubit, WerdState>(
                builder: (context, state) {
                  if (state is WerdSuccess) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(AppPadding.p8),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 10 / 3,
                      ),
                      //itemCount: state.sours.length,
                      itemCount: state.werds.length,
                      itemBuilder: (context, index) => WerdWidget(
                        werd: state.werds[index],
                        index: index,
                      ),
                    );
                  } else if (state is WerdLoading) {
                    return const FullLoadingScreenAnimated(
                        message: 'قم بإضافة الورد الخاص بك');
                  } else {
                    return StateRender.fullLoadingScreenImage;
                  }
                },
              ),
              const SizedBox(height: AppSize.s20),
            ],
          ),
        ),
      ),
    );
  }
}
