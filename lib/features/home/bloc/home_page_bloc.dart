import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState()) {
    {
      on<HomePageBottomBarChange>((event, emit) {
        emit(HomePageState(index: event.selectedIndex));
      });
    }
  }
}
