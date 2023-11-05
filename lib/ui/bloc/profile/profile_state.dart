import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileEmptyState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  late final String profilePhotoPath;
  ProfileLoadedState({required this.profilePhotoPath});

  @override
  List<Object?> get props => [profilePhotoPath];
}

class ProfilePermissionDeniedState extends ProfileState {}

class ProfileNoImageSelectedState extends ProfileState {}

class ProfilePermissionPermanentlyDeniedState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  late final String errorMessage;
  ProfileErrorState({required this.errorMessage});
}
