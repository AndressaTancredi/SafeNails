import 'package:bloc/bloc.dart';
import 'package:safe_nails/common/image_picker_service.dart';
import 'package:safe_nails/ui/bloc/profile/profile_event.dart';
import 'package:safe_nails/ui/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late String photoPath = '';

  ProfileBloc() : super(ProfileEmptyState()) {
    on<NewPhotoEvent>(_newProfilePhoto);
  }

  void _newProfilePhoto(ProfileEvent event, Emitter<ProfileState> emit) async {
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
  }
}
