import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';

class SalahWidget extends StatelessWidget {
  final SalahModel salah;
  const SalahWidget({required this.salah,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(salah.icon),
                  SizedBox(width: 10,),
                  Text(salah.name),
                ],
              ),
             // Text("${oh} س : ${om} د "),
              Text(arTime(salah.time)),
            ],
          ),
        ),
      ),
    );
  }
}
