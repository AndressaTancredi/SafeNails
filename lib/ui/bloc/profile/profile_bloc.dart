import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_nails/common/image_picker_service.dart';
import 'package:safe_nails/ui/bloc/profile/profile_event.dart';
import 'package:safe_nails/ui/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late String photoPath = '';

  ProfileBloc() : super(ProfileEmptyState()) {
    on<NewPhotoEvent>(_newProfilePhoto);
  }

  void _newProfilePhoto(ProfileEvent event, Emitter<ProfileState> emit) async {
    // Check for permissions first
    final permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      // Permission is granted; proceed to pick an image
      final ImagePickerService imagePickerService = ImagePickerService();

      try {
        final pickedImage = await imagePickerService.pickImageFromGallery();
        if (pickedImage != null) {
          photoPath = pickedImage.path;
          emit(ProfileLoadingState());
          emit(ProfileLoadedState(profilePhotoPath: photoPath));
        } else {
          // No image selected
          emit(ProfileNoImageSelectedState());
        }
      } catch (e) {
        // Error picking the image
        emit(ProfileErrorState(errorMessage: e.toString()));
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      // Permission is permanently denied
      emit(ProfilePermissionPermanentlyDeniedState());
    } else {
      // Permission is denied (but not permanently). You can ask the user to enable it from settings.
      final isRequested = await Permission.photos.request().isGranted;
      if (!isRequested) {
        // Permission denied after requesting
        emit(ProfilePermissionDeniedState());
      }
    }
  }
}
