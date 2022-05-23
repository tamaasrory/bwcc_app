import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/bloc/bottom_navbar_bloc.dart';
import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/bloc/profile_bloc.dart';
import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/bloc/residence_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BWCC Mobile',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('id', ''), // indonesia, no country code
      ],
      locale: const Locale('id'),
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
            BlocProvider(create: (context) => BerandaBloc()),
            BlocProvider(create: (context) => AuthBloc()),
            BlocProvider(create: (context) => BottomNavbarBloc()),
            BlocProvider(create: (context) => ReservasiBloc()),
            BlocProvider(create: (context) => ProfileBloc()),
            BlocProvider(create: (context) => ResidenceBloc()),
          ],
          child: child!,
        );
      },
      home: const SplashPage(),
    );
  }
}
