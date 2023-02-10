part of 'hesn_cubit.dart';

@immutable
abstract class HesnState {
  const HesnState();
}

class HesnInitial extends HesnState {}
class HesnSuccess extends HesnState {
  final List<HesnModel> hesnList;
  const HesnSuccess(this.hesnList);
}
class HesnLoading extends HesnState {}
