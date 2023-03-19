import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/features/common_widgets/show_snackBar.dart';
import 'package:holly_quran/features/ihdaa/ihdaa_image.dart';
import 'package:signature/signature.dart';


class IhdaaView extends StatefulWidget {
  const IhdaaView({Key? key}) : super(key: key);

  @override
  State<IhdaaView> createState() => _IhdaaViewState();
}

class _IhdaaViewState extends State<IhdaaView> {
  // initialize the signature controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: AppColors.primary,
    exportBackgroundColor: AppColors.ihdaaSignatureBoard,
    exportPenColor: AppColors.white,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isGeneralSelected = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => log('Value changed'));
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  Future<void> exportImage(BuildContext context) async {
    if (_controller.isEmpty || _nameController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        buildSnackBar(context,title: AppStrings.noData,background: AppColors.reset,)
      );
      return;
    }

    final Uint8List? data =
    await _controller.toPngBytes(height: int.parse("${AppSize.s400}"), width: int.parse("${AppSize.s400}"));
    if (data == null) {
      return;
    }

    if (!mounted) return;

    await push(
      context,data
    );
  }

  Future push(context, data) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return IhdaaImage(name: _nameController.text,
            content: _contentController.text, signature: data,
            isGeneral: isGeneralSelected,);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s50),
          child: MyAppBar(title: AppStrings.ihdaa),
        ),
        body: Container(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: ListView(
            children: [
              const SizedBox(height: AppSize.s10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: AppStrings.name,
                ),
                controller: _nameController,
              ),
              const SizedBox(height: AppSize.s10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: AppStrings.content,
                ),
                minLines: 3,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                controller: _contentController,
              ),
              const SizedBox(height: AppSize.s20),
               Text(AppStrings.ihdaaType,style: Theme.of(context).textTheme.headlineLarge,),
              const SizedBox(height: AppSize.s10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isGeneralSelected = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isGeneralSelected
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(AppSize.s4),
                      ),
                      padding:  const EdgeInsets.symmetric(
                        horizontal: AppPadding.p12,
                        vertical: AppPadding.p6,
                      ),
                      child: Text(
                        AppStrings.ihdaaGeneral,
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: isGeneralSelected
                              ? AppColors.primary
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isGeneralSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: !isGeneralSelected
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(AppSize.s4),
                      ),
                      padding:  const EdgeInsets.symmetric(
                        horizontal: AppPadding.p12,
                        vertical: AppPadding.p6,
                      ),
                      child: Text(AppStrings.ihdaaRamadan,
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: !isGeneralSelected
                              ? AppColors.primary
                              : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s20),
              Text(AppStrings.ihdaaSign,style: Theme.of(context).textTheme.headlineLarge,),
              const SizedBox(height: AppSize.s10),
              Signature(
                key: const Key('signature'),
                controller: _controller,
                height: AppSize.s300,
                backgroundColor: AppColors.greyLight,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(color: AppColors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //SHOW EXPORTED IMAGE IN NEW ROUTE
                IconButton(
                  key: const Key('exportPNG'),
                  icon: const Icon(Icons.image),
                  color: AppColors.white,
                  onPressed: () => exportImage(context),
                  tooltip: 'Export Image',
                ),
                IconButton(
                  icon: const Icon(Icons.undo),
                  color: AppColors.white,
                  onPressed: () {
                    setState(() => _controller.undo());
                  },
                  tooltip: 'Undo',
                ),
                IconButton(
                  icon: const Icon(Icons.redo),
                  color: AppColors.white,
                  onPressed: () {
                    setState(() => _controller.redo());
                  },
                  tooltip: 'Redo',
                ),
                //CLEAR CANVAS
                IconButton(
                  key: const Key('clear'),
                  icon: const Icon(Icons.clear),
                  color: AppColors.white,
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                  tooltip: 'Clear',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
