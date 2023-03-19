import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/features/common_widgets/state_renderer/state_render.dart';
import 'package:holly_quran/features/quran_agzaa/presentation/view_models/agzaa_cubit.dart';

class JuzhViewBody extends StatefulWidget {
  final int startPage;
  // final int endPage;

  const JuzhViewBody({required this.startPage, Key? key})
      : super(key: key);

  @override
  State<JuzhViewBody> createState() => _JuzhViewBodyState();
}

class _JuzhViewBodyState extends State<JuzhViewBody> {
  late final PageController boardController;
  late final List<String> pages;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      boardController = PageController(initialPage: widget.startPage - 1);
      setState(() {});
    });
    pages = BlocProvider.of<AgzaaCubit>(context).juzhSour;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgzaaCubit, AgzaaState>(
      builder: (context, state) {
        if(state is OpenJuzh){
          return PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: boardController,
            onPageChanged: (index) {},
            allowImplicitScrolling: false,
            itemBuilder: (context, index) {
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  pages[index],
                  fit: BoxFit.fill,
                ),
              );
            },
            itemCount: pages.length,
          );
        }else{
          return StateRender.fullLoadingScreenImage;
        }
      },
    );
  }
}


