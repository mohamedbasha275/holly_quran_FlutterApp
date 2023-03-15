import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
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
    const String phone = '01063981560';
    final url = 'whatsapp://send?phone=$phone&text=${Uri.parse(message)}';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              width: 200,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/icon.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
                'إسلامنا تطبيق إسلامي لتقديم  بعض الخدمات والمميزات الدينية لمساعدتك في الحفاظ علي يومك',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17
              ),
            ),
            const SizedBox(height: 30.0),
            Align(
              alignment: Alignment.centerRight,
              child: Text('قم بإرسال أي مقترح أو شكوي عبر الواتساب:',
                style: TextStyle(
                    fontSize: 15,
                  color: Colors.red,
                  decoration: TextDecoration.underline
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _validateForm(),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _formValid ? _submitForm : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey;
                      }
                      return AppColors.primary;
                    },
                  ),
                ),
                child: Text(
                  'إرسال الآن',
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
