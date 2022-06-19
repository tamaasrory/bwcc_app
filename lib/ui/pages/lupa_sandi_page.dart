import 'dart:io';
import 'dart:math';

import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/pages/auth_page.dart';
import 'package:bwcc_app/ui/pages/splash_page.dart';
import 'package:bwcc_app/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LupaSandiPage extends StatefulWidget {
  const LupaSandiPage({Key? key}) : super(key: key);

  @override
  State<LupaSandiPage> createState() => _LupaSandiPageState();
}

class _LupaSandiPageState extends State<LupaSandiPage> {
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
                      Text(
                        "Lupa Kata Sandi",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 24,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const RegisterForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String? email;
  bool valid = false;
  String reset = '1234';

  _isValid() {
    return email != null && valid;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFieldWidget(
            key: ObjectKey(reset),
            label: 'Email',
            hint: 'Masukkan alamat email Anda',
            value: email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                valid = false;
                return 'Email tidak boleh kosong';
              }
              if (!validMail(value)) {
                valid = false;
                return 'Email tidak valid';
              }
              valid = true;
              return null;
            },
            inputType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          const SizedBox(height: 30),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthProgessState) {
                if (state.extra != null) {
                  showToast(context, state.extra.message);
                  if (state.extra.condition) {
                    reset = Random(5).toString();
                    email = null;
                    setState(() {});
                  }
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
                          : () => context.read<AuthBloc>().add(ForgotPasswordEvent(email.toString())))
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
                            Text('Mohon Menunggu', style: TextStyle(fontSize: 20))
                          ],
                        )
                      : const Text('Reset Password', style: TextStyle(fontSize: 20)),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sudah punya akun ?',
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const AuthPage(),
                    ),
                  );
                },
                child: Text(
                  'Sign In',
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
