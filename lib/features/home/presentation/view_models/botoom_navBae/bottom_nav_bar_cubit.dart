import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/hadith_view_body.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());
  int currentIndex = 5;
  int allItemsCount = 5;
  // changeIndex function
  void changeIndex({required int index}) {
    currentIndex = index;
    emit(BottomNavBarInitial()); // to listen for change
  }
}
