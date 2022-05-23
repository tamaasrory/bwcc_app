import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/user.dart';
import 'package:bwcc_app/ui/pages/daftar_keluarga_page.dart';
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
      statusBarIconBrightness: Brightness.dark,
    ));

    var _state = context.watch<AuthBloc>().state;
    AuthAttampState authState = (_state is AuthAttampState) ? _state : AuthAttampState(data: User());
    logApp(authState.data.toJson().toString());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: HexColor('#eeeeee')),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: authState.data.accessToken != null
                        ? Image.network(
                            Urls.getStorage(authState.data.avatar.toString()),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/banner-1.jpg',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                authState.data.username.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0.0, 2.0),
                        blurRadius: 5,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          title: Text(
                            authState.data.noHandphone.toString(),
                            style: TextStyle(color: HexColor('#757575')),
                          ),
                          leading: const Icon(Icons.phone),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text(
                            authState.data.email.toString(),
                            style: TextStyle(color: HexColor('#757575')),
                          ),
                          leading: const Icon(Icons.mail),
                          onTap: () {},
                        ),
                      ],
                    ).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0.0, 2.0),
                        blurRadius: 5,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          title: const Text('Profile'),
                          leading: const Icon(Icons.manage_accounts_rounded),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Daftar Keluarga'),
                          leading: const Icon(Icons.bookmark),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DaftarKeluargaPage(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Ganti Password'),
                          leading: const Icon(Icons.lock),
                          onTap: () {},
                        ),
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthAttampState) {
                              if (!state.isLogged) {
                                Navigator.of(context, rootNavigator: true).pushReplacement(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => const AuthPage(),
                                  ),
                                );
                              }
                            }
                          },
                          child: ListTile(
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            leading: Icon(
                              Icons.logout_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onTap: () {
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
                          ),
                        ),
                      ],
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
