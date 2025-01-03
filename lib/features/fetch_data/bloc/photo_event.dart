part of 'photo_bloc.dart';

sealed class PhotoEvent {}

class PhotoFetch extends PhotoEvent {
  String url;
  PhotoFetch({required this.url});
}

class SinglePhotoFetch extends PhotoEvent {
  String url;
  SinglePhotoFetch({required this.url});
}
