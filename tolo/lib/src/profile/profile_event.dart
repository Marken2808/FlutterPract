part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class FetchAvatarProfileEvent extends ProfileEvent {
  final User user;
  FetchAvatarProfileEvent({
    required this.user,
  });
}

class UpAvatarProfileEvent extends ProfileEvent {}

class ImgPickerProfileEvent extends ProfileEvent {
  ImageSource imageSource;
  ImgPickerProfileEvent({
    required this.imageSource,
  });
}

class ImgPathProfileEvent extends ProfileEvent {
  final String avatarPath;

  ImgPathProfileEvent({required this.avatarPath});
}

class UpDescriptionProfileEvent extends ProfileEvent {
  final String description;

  UpDescriptionProfileEvent({required this.description});
}

class SaveProfileEvent extends ProfileEvent {
  User user;
  SaveProfileEvent({
    required this.user,
  });
}
