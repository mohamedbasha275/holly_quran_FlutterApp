import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/quran_app_bar.dart';
//
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';

class SadaqaSurahView extends StatefulWidget {
  final String name;
  final String pageNumber;

  SadaqaSurahView({super.key, required this.name, required this.pageNumber});

  @override
  State<SadaqaSurahView> createState() => _SadaqaSurahViewState();
}

class _SadaqaSurahViewState extends State<SadaqaSurahView> {
  bool showNameContainer = false; // State to control visibility
  final GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    int pageNum = int.parse(widget.pageNumber);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s50),
          child: QuranAppBar(title: widget.name),
        ),
        body: RepaintBoundary(
          key: _globalKey,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                if (showNameContainer == true) // Conditionally display the Container
                Container(
                  width: context.width,
                  color: AppColors.primary,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    '$quranData$pageNum.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: StadiumBorder(),
          backgroundColor: AppColors.secondary.withOpacity(0.8),

          onPressed: _shareImage,
          child: const Icon(Icons.share),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      ),
    );
  }

  Future<void> _shareImage()  async{
    setState(() {
      showNameContainer = true; // Show the container before sharing
    });
    Future.delayed(Duration(milliseconds: 100),()async{
      try {
        RenderRepaintBoundary boundary = _globalKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        final directory = await getApplicationDocumentsDirectory();
        String imagePath = '${directory.path}/ihdaa_image.png';
        File imgFile = File(imagePath);
        await imgFile.writeAsBytes(pngBytes);

        // Using shareXFiles instead of deprecated shareFiles
        await Share.shareXFiles([XFile(imagePath)],);
            // text: 'Check out this image!');
        setState(() {
          showNameContainer = false; // Optionally hide it again after sharing
        });
      } catch (e) {
        print(e.toString());
      }
    },);
  }
}
