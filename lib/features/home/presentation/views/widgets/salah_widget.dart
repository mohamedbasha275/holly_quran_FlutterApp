import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/salah/surah_model.dart';

class SalahWidget extends StatelessWidget {
  final SalahModel salah;
  final Color color;
  const SalahWidget({required this.salah,required this.color,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dt1 = DateTime.now();
    DateTime dt2 = salah.dateTime;
    print(dt2);
    Duration diff = dt2.difference(dt1);
    var oh = diff.inHours;
    var om = diff.inMinutes;
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      child: Card(
        color: color,
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
             Text("${oh} س : ${om} د "),
              Text(arTime(salah.time)),
            ],
          ),
        ),
      ),
    );
  }
}
