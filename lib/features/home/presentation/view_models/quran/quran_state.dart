part of 'quran_cubit.dart';

@immutable
abstract class QuranState {
  const QuranState();
}

class QuranInitial extends QuranState {}

class QuranSuccess extends QuranState {
  final List<SurahModel> sours;
  final int stopSurah;
  final int stopAya;
  const QuranSuccess(this.sours,this.stopSurah,this.stopAya);
}