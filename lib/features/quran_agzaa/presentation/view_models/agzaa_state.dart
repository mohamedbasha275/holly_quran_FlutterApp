part of 'agzaa_cubit.dart';

@immutable
abstract class AgzaaState {
  const AgzaaState();
}

class AgzaaInitial extends AgzaaState {}
class AgzaaSuccess extends AgzaaState {}
class AgzaaLoading extends AgzaaState {}
class OpenJuzh extends AgzaaState {}
