// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment_app/core/routes/names.dart';
import 'package:assignment_app/dependencies_initialization.dart';
import 'package:assignment_app/features/fetch_data/bloc/photo_bloc.dart';
import 'package:assignment_app/features/fetch_data/pages/fetch_api_page.dart';
import 'package:assignment_app/features/fetch_data/pages/photo_detail_page.dart';
import 'package:assignment_app/features/home/bloc/home_page_bloc.dart';
import 'package:assignment_app/features/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}

class AppPages {
  static List<PageEntity> route() {
    return [
      PageEntity(
        route: AppRoutes.HOME_PAGE,
        page: HomePage(),
        bloc: BlocProvider(
          create: (_) => getIt<HomePageBloc>(),
        ),
      ),
      PageEntity(
        route: AppRoutes.PHOTO_PAGE,
        page: FetchApiPage(),
        bloc: BlocProvider(
          create: (_) => getIt<PhotoBloc>(),
        ),
      ),
      PageEntity(
        route: AppRoutes.PRODUCT_DETAIL_PAGE,
        page: PhotoDetailPage(),
        bloc: BlocProvider(
          create: (_) => getIt<PhotoBloc>(),
        ),
      ),
      PageEntity(
        route: AppRoutes.FORM_PAGE,
        page: FetchApiPage(),
        // bloc: BlocProvider(
        //   create: (_) => getIt<PhotoBloc>(),
        // ),
      ),
    ];
  }

  // storing all the blocs at one place..
  static List<BlocProvider> allBlocProviders(BuildContext context) {
    List<BlocProvider> blocProviders = <BlocProvider>[];
    for (var pageEntity in route()) {
      if (pageEntity.bloc != null) {
        blocProviders.add(pageEntity.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRoute(RouteSettings settings) {
    if (settings.name != null) {
      var result = route().where((element) => settings.name == element.route);
      if (result.isNotEmpty) {
        print('Valid route name ${settings.name}'); // Debugging line

        print(result.first.page);
        return MaterialPageRoute(
          builder: (_) => result.first.page,
          settings: settings,
        );
      }
    }
    print('Invalid route name ${settings.name}'); // Debugging line
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
            'Page Does Not Exist',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
