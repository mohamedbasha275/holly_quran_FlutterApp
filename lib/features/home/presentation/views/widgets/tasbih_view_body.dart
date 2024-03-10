import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/awsome_dialoge.dart';
import 'package:holly_quran/features/common_widgets/show_snackBar.dart';
import 'package:holly_quran/features/common_widgets/state_renderer/state_render.dart';
import 'package:holly_quran/features/home/presentation/view_models/tasbeh/tasbeh_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/tasbih_widget.dart';

class TasbihViewBody extends StatelessWidget {
  const TasbihViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController counterController = TextEditingController();
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
              Image.asset(ImageAssets.dua, width: AppSize.s100),
              Text(
                'اللهم أجعلنا من الذاكرين',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              AppAwesomeDialog(
                controller: nameController,
                title: 'إضافة ذكر جديد',
                controller2: counterController,
                function: () {
                  BlocProvider.of<TasbehCubit>(context)
                      .addOneTasbih(name: nameController.text, counter: int.parse(counterController.text))
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      buildSnackBar(
                        context,
                        title: 'تم الإضافة بنجاح',
                        background: AppColors.primary,
                      ),
                    );
                    nameController.text = '';
                  });
                },
              ),
              const Divider(),
              BlocBuilder<TasbehCubit, TasbehState>(
                builder: (context, state) {
                  if (state is TasbehSuccess) {
                    return SizedBox(
                      height: context.height *0.61,
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(AppPadding.p8),
                          itemCount: state.tasbih.length,
                          itemBuilder: (context, index) => TasbihWidget(
                            tasbih: state.tasbih[index],
                          ),
                        ),
                      ),
                    );
                  } else if (state is TasbehLoading) {
                    return const FullLoadingScreenAnimated(
                      message: 'إضافة ذكر',
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
