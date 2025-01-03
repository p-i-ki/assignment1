part of 'photo_bloc.dart';

sealed class PhotoState {}

class PhotoStateInitial extends PhotoState {}

class PhotoStateLoading extends PhotoState {}

class PhotoStateSuccess extends PhotoState {
  final List<Photo> photos;

  PhotoStateSuccess({required this.photos});
}

class PhotoStateError extends PhotoState {
  final String error;
  PhotoStateError({required this.error});
}

class SinglePhotoLoadingState extends PhotoState {}

class SinglePhotoSuccessState extends PhotoState {
  final List<Photo> photos;

  SinglePhotoSuccessState({required this.photos});
}

class SinglePhotoStateError extends PhotoState {
  final String error;
  SinglePhotoStateError({required this.error});
}
