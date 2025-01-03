import 'package:assignment_app/core/api/photo_fetch.dart';
import 'package:assignment_app/core/models/photo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoStateInitial()) {
    on<PhotoFetch>(_photoFetch);
    on<SinglePhotoFetch>(_singlePhotoFetch);
  }

  void _photoFetch(PhotoFetch event, Emitter<PhotoState> emit) async {
    emit(PhotoStateLoading());
    try {
      final url = event.url;
      final response = await fetchPhotos(url);
      emit(PhotoStateSuccess(photos: response));
    } catch (error) {
      emit(PhotoStateError(error: error.toString()));
    }
  }

  void _singlePhotoFetch(
      SinglePhotoFetch event, Emitter<PhotoState> emit) async {
    emit(SinglePhotoLoadingState());
    try {
      final url = event.url;
      final response = await fetchPhotos(url);
      emit(SinglePhotoSuccessState(photos: response));
    } catch (error) {
      emit(SinglePhotoStateError(error: error.toString()));
    }
  }
}
