part of 'form_page_bloc.dart';

@immutable
sealed class FormPageEvent {}

class FormSubmitEvent extends FormPageEvent {
  final User user;
  FormSubmitEvent({required this.user});
}
