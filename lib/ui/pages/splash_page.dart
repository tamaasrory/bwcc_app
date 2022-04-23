// ignore_for_file: deprecated_member_use

import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/pages/auth_page.dart';
import 'package:bwcc_app/ui/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late BuildContext myContext;
  String appVersion = '';

  @override
  void initState() {
    myContext = context;
    Future.delayed(const Duration(seconds: 3), () {
      BlocProvider.of<AuthBloc>(context).add(CheckAndSetupLoginEvent());
    });
    if (mounted) {
      AppConfig.getAppDetail().then((value) {
        appVersion = value.version;
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              if (state is AuthAttampState) {
                if (state.isLogged) {
                  return const MainPage();
                }
              }
              return const AuthPage();
            },
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      AppAssets.logoNew,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mitra",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Perempuan",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 18,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sahabat",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Anak",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 18,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(height: 20),
                    Text(
                      'V ' + appVersion,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
