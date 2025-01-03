import 'package:assignment_app/features/audio_player/pages/audio_player.dart';
import 'package:assignment_app/features/fetch_data/pages/fetch_api_page.dart';
import 'package:assignment_app/features/form_field/pages/form_page.dart';
import 'package:assignment_app/features/home/bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Pages for the BottomNavigationBar
  final List<Widget> _pages = [
    const FetchApiPage(),
    const UserFormPage(),
    const AudioPlayerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.index,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: (value) {
              context
                  .read<HomePageBloc>()
                  .add(HomePageBottomBarChange(selectedIndex: value));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: "Fetch API",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: "User Form",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.my_library_music_outlined, size: 30),
                label: "Audio Player",
              ),
            ],
          ),
        );
      },
    );
  }
}
