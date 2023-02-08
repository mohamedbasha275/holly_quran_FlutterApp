part of 'salah_cubit.dart';

@immutable
abstract class SalahState {
  const SalahState();
}

class SalahInitial extends SalahState {}

class SalahLoading extends SalahState {}

class SalahSuccess extends SalahState {
  final List<SalahModel> salah;
  const SalahSuccess(this.salah);
}
