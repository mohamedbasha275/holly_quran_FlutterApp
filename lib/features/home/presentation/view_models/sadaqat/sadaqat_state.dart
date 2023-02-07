part of 'sadaqat_cubit.dart';

@immutable
abstract class SadaqatState {
  const SadaqatState();
}

class SadaqatInitial extends SadaqatState {}


class SadaqatLoading extends SadaqatState {}

class SadaqatSuccess extends SadaqatState {
  final List<String> sadaqat;
  const SadaqatSuccess(this.sadaqat);
}
