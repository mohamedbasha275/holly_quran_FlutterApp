import 'package:flutter/material.dart';
import 'package:holly_quran/features/common_widgets/custom_button.dart';

class BookAction extends StatelessWidget {
  const BookAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: const [
          Expanded(
            child: CustomButton(
              title: 'Free',
              textColor: Colors.black,
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          Expanded(
            child: CustomButton(
              title: 'Free Preview',
              textColor: Colors.white,
              fontSize: 16,
              backgroundColor: Color(0xffEF8262),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
