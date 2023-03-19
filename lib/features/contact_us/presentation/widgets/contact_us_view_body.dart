import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsViewBody extends StatefulWidget {
  const ContactUsViewBody({Key? key}) : super(key: key);

  @override
  State<ContactUsViewBody> createState() => _ContactUsViewBodyState();
}

class _ContactUsViewBodyState extends State<ContactUsViewBody> {
  final TextEditingController _messageController = TextEditingController();
  bool _formValid = false;

  void _validateForm() {
    setState(() {
      _formValid = _messageController.text.isNotEmpty;
    });
  }

  void _submitForm() async {
    final message = _messageController.text.trim();
    const String phone = AppConstants.whatsPhone;
    final url = 'whatsapp://send?phone=$phone&text=${Uri.parse(message)}';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20)),
              width: AppSize.s200,
              height: AppSize.s200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s20),
                child: Image.asset(
                  ImageAssets.icon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s16),
            const Text(
              AppStrings.contactTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: FontSize.s17),
            ),
            const SizedBox(height: AppSize.s30),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppStrings.sendWhats,
                style: TextStyle(
                    fontSize: FontSize.s15,
                    color: AppColors.red,
                    decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: AppSize.s16),
            TextField(
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: AppStrings.contactMessage,
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _validateForm(),
            ),
            const SizedBox(height: AppSize.s16),
            SizedBox(
              height: AppSize.s60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _formValid ? _submitForm : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return AppColors.grey;
                      }
                      return AppColors.primary;
                    },
                  ),
                ),
                child: Text(
                  AppStrings.sendNow,
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
