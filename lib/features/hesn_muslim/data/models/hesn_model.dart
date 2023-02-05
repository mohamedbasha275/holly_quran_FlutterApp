import 'package:holly_quran/features/hesn_muslim/data/models/hesn_tip_model.dart';

class HesnModel{
  final int id;
  final String title;
  final List<HesnTipModel> tips;
  bool expanded;
  HesnModel({required this.id,required this.title,required this.tips,this.expanded= false});
}