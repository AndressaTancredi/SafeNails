import 'package:equatable/equatable.dart';

abstract class TipsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HydrationState extends TipsState {}

class CleansingState extends TipsState {}

class ProtectionState extends TipsState {}
