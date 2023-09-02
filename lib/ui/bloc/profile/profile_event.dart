abstract class ProfileEvent {}

class PhotoProfileAttachmentEvent extends ProfileEvent {
  PhotoProfileAttachmentEvent();
}

class NewPhotoEvent extends ProfileEvent {
  NewPhotoEvent();
}
