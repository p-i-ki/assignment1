part of 'home_page_bloc.dart';

sealed class HomePageEvent {}

class HomePageBottomBarChange extends HomePageEvent {
  int selectedIndex;
  HomePageBottomBarChange({required this.selectedIndex});
}
