import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/user.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loadImgProfile = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.light,
    ));

    var _state = context.watch<AuthBloc>().state;
    AuthAttampState authState = (_state is AuthAttampState) ? _state : AuthAttampState(data: User());

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8),
            color: Theme.of(context).colorScheme.primary,
            child: SafeArea(
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                      onPressed: () {
                        // Navigator.pop(context, false);
                      },
                      child: Image.asset(AppAssets.backWhite, width: 32, height: 32),
                    ),
                    const Text(
                      'PROFIL ANDA',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Image.asset(AppAssets.icLogo, width: 40, height: 40),
                  ],
                ),
              ),
            ),
          ),
          Image.asset(AppAssets.bgHeader, fit: BoxFit.cover),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 25),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Icon(
                              Icons.account_circle,
                              size: 90,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  authState.data.username.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                const Divider(thickness: 1.5),
                                Text(
                                  AppDateTime(authState.data.createdAt.toString()).format('d MMM yyyy'),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  authState.data.noHandphone.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  authState.data.email.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: IconButton(
                              onPressed: () => {},
                              icon: Icon(
                                Icons.edit,
                                size: 32,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthAttampState) {
                            if (!state.isLogged) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => const AuthPage(),
                                ),
                              );
                            }
                          }
                        },
                        child: OutlinedButton(
                          onPressed: () {
                            dialogConfirm(
                              context,
                              title: 'Logout',
                              messages: 'Apakah Anda ingin logout sekarang juga ?',
                              negativeText: 'TIDAK',
                              positiveText: 'YA',
                              positiveAction: () {
                                BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                              },
                              dismissable: true,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            side: BorderSide(color: Theme.of(context).colorScheme.secondary),
                            primary: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.logout_rounded),
                              SizedBox(width: 10),
                              Text(
                                'Keluar',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
