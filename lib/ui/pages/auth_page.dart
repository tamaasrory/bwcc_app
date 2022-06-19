import 'dart:io';

import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/pages/lupa_sandi_page.dart';
import 'package:bwcc_app/ui/pages/register_page.dart';
import 'package:bwcc_app/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark,
    ));

    return WillPopScope(
      onWillPop: () async => exit(0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(35),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.asset(
                          AppAssets.logoNew,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mitra",
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 12,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Perempuan",
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 12,
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
                                  fontSize: 12,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Anak",
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 12,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Hi, Selamat Datang !',
                  style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                const LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showPassword = true;
  String _email = '';
  String _password = '';

  _isValid() {
    return _email.isNotEmpty && _password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Email',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 2),
          TextFormField(
            // autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              hintText: 'Silahkan Masukkan Email Yang Terdaftar',
              border: UnderlineInputBorder(),
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            style: const TextStyle(fontSize: 16),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              if (!validMail(value)) {
                return 'Email tidak valid';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Password',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 2),
          TextFormField(
            // autofocus: true,
            obscureText: _showPassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              hintText: 'Masukkan Password',
              border: const UnderlineInputBorder(),
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
              suffixIcon: IconButton(
                icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
            ),
            style: const TextStyle(fontSize: 16),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          const SizedBox(height: 30),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAttampState) {
                if (state.isLogged) {
                  // navigate to splash page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SplashPage(),
                    ),
                  );
                } else {
                  showToast(context, state.message, position: MediaQuery.of(context).size.height - 200);
                }
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                bool loading = (state is AuthProgessState) ? state.loading : false;

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _isValid()
                      ? (loading
                          ? () => {}
                          : () => context.read<AuthBloc>().add(LoginEvent(
                                _email,
                                _password,
                              )))
                      : null,
                  child: loading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Mohon Tunggu', style: TextStyle(fontSize: 20))
                          ],
                        )
                      : const Text('Masuk', style: TextStyle(fontSize: 20)),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const LupaSandiPage()));
                },
                child: const Text(
                  'Lupa Kata Sandi ?',
                  style: TextStyle(color: Colors.grey),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
                },
                child: Text(
                  'Daftar',
                  style: TextStyle(color: AppColors.softPink),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 36),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
