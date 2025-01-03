import 'package:assignment_app/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_page_event.dart';
part 'form_page_state.dart';

class FormPageBloc extends Bloc<FormPageEvent, FormPageState> {
  FormPageBloc() : super(FormPageInitial()) {
    on<FormSubmitEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
