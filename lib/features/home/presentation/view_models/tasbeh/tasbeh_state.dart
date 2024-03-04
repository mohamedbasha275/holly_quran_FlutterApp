part of 'tasbeh_cubit.dart';

@immutable

abstract class TasbehState {
  const TasbehState();
}

class TasbehInitial extends TasbehState {}


class TasbehLoading extends TasbehState {}

class TasbehSuccess extends TasbehState {
  final List<TasbihModel> tasbih;
  const TasbehSuccess(this.tasbih);
}
