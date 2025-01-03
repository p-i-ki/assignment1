import 'package:assignment_app/core/routes/pages.dart';
import 'package:assignment_app/dependencies_initialization.dart';
import 'package:assignment_app/features/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  //configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppPages.allBlocProviders(context),
      child: MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Assignment',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
        onGenerateRoute: (settings) => AppPages.generateRoute(settings),
      ),
    );
  }
}

// void configLoading() {
//   EasyLoading.instance
//     ..backgroundColor = Colors.transparent
//     ..indicatorColor = Colors.blue
//     ..maskColor = Colors.black.withValues(alpha: 0.5)
//     ..dismissOnTap = true;
// }
