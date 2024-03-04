import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';


class IhdaaImage extends StatefulWidget {
  final String name;
  final String content;
  final Uint8List signature;
  final bool isGeneral;

  const IhdaaImage({
    Key? key,
    required this.name,
    required this.content,
    required this.signature,
    required this.isGeneral,
  }) : super(key: key);

  @override
  _IhdaaImageState createState() => _IhdaaImageState();
}

class _IhdaaImageState extends State<IhdaaImage> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> _shareImage() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      String imagePath = '${directory.path}/ihdaa_image.png';
      File imgFile = File(imagePath);
      await imgFile.writeAsBytes(pngBytes);

      // Using shareXFiles instead of deprecated shareFiles
      await Share.shareXFiles([XFile(imagePath)], text: 'Check out this image!');
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s50), // Replace with your actual app size
          child: MyAppBar(title: AppStrings.ihdaa), // Replace with your actual app bar
        ),
        body: RepaintBoundary(
          key: _globalKey,
          child: Container(
            height: context.height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.isGeneral ? ImageAssets.generalIhdaa : ImageAssets.ramadanIhdaa),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: AppColors.black45,
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Text(
                            'إهداء إلي : ${widget.name}',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: FontSize.s25),
                          ),
                        ),
                        SizedBox(height: context.height * 0.15),
                        Container(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          color: AppColors.black45,
                          child: Text(
                            widget.content,
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: FontSize.s25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                      ),
                      width: AppSize.s150,
                      height: AppSize.s150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                        child: Image.memory(widget.signature),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: StadiumBorder(),
          onPressed: _shareImage,
          child: Icon(Icons.share),
        ),
      ),
    );
  }
}
