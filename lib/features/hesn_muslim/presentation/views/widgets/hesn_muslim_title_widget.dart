import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

class HesnMuslimTitleWidget extends StatelessWidget {
  final String title;

  const HesnMuslimTitleWidget({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Text(title,style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}
