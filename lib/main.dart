import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/bloc/bottom_navbar_bloc.dart';
import 'package:bwcc_app/bloc/home_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.softTeal,
              secondary: AppColors.softPink,
              background: AppColors.softWhite,
            ),
        textTheme: Theme.of(context).textTheme.copyWith(
              labelMedium: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.softPink,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      // routes: routes,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeBloc()),
            BlocProvider(create: (context) => AuthBloc()),
            BlocProvider(create: (context) => BottomNavbarBloc()),
          ],
          child: child!,
        );
      },
      home: const SplashPage(),
    );
  }
}
