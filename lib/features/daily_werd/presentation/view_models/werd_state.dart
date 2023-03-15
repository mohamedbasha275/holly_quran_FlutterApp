part of 'werd_cubit.dart';

@immutable
abstract class WerdState {
  const WerdState();
}

class WerdInitial extends WerdState {}
class WerdSuccess extends WerdState {
  final List<WerdModel> werds;
  const WerdSuccess(this.werds);
}
class WerdLoading extends WerdState {}
