import 'dart:io';

import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/form_register.dart';
import 'package:bwcc_app/ui/pages/auth_page.dart';
import 'package:bwcc_app/ui/pages/splash_page.dart';
import 'package:bwcc_app/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                        "Daftar",
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
  FormRegister formRegister = FormRegister();
  bool _showPassword = true;
  String _repeatPassword = '';
  bool _acc = false;

  _isValid() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFieldWidget(
            label: 'Email',
            hint: 'Masukkan alamat email Anda',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              if (!validMail(value)) {
                return 'Email tidak valid';
              }
              return null;
            },
            inputType: TextInputType.emailAddress,
            onChanged: (value) {
              formRegister.email = value!;
              setState(() {});
            },
          ),
          const SizedBox(height: 20),
          TextFieldWidget(
            label: 'Password',
            hint: 'Masukkan Password (6 karakter)',
            hideText: _showPassword,
            suffixIcon: IconButton(
              icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 8) {
                return 'Password minimal 8 karakter';
              }
              return null;
            },
            onChanged: (value) {
              formRegister.password = value!;
              setState(() {});
            },
          ),
          const SizedBox(height: 20),
          TextFieldWidget(
            label: 'Ulangi Password',
            hint: 'Masukkan ulang password diatas',
            hideText: _showPassword,
            suffixIcon: IconButton(
              icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 8) {
                return 'Password minimal 8 karakter';
              }
              if (_repeatPassword != formRegister.password) {
                return 'Password tidak sama';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _repeatPassword = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Nomor Telepon',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 2),
          IntlPhoneField(
            decoration: const InputDecoration(
              hintText: 'Masukkan nomor telepon anda',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              border: UnderlineInputBorder(),
            ),
            initialCountryCode: 'ID',
            onChanged: (phone) {
              formRegister.noHandphone = phone.completeNumber;
              setState(() {});
            },
            showCountryFlag: false,
            showDropdownIcon: false,
            disableLengthCheck: true,
            invalidNumberMessage: 'Nomor tidak valid',
            validator: (value) {
              if (value == null || value.number.isEmpty) {
                return 'Nomor Telepon tidak boleh kosong';
              }
              if (value.number.length < 4) {
                return 'Nomor Telepon minimal 4 karakter';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFieldWidget(
            label: 'Nama Lengkap',
            hint: 'Masukkan nama lengkap Anda',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama lengkap tidak boleh kosong';
              }
              return null;
            },
            inputType: TextInputType.text,
            onChanged: (value) {
              formRegister.username = value!;
              setState(() {});
            },
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: Checkbox(
                    value: _acc,
                    onChanged: (value) {
                      _acc = value!;
                      setState(() {});
                    }),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    _acc = !_acc;
                    setState(() {});
                  },
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Saya Menerima segala isi ',
                        ),
                        TextSpan(
                          text: 'Syarat Penggunan',
                          style: TextStyle(color: AppColors.softPink),
                        ),
                        const TextSpan(
                          text: ' dan ',
                        ),
                        TextSpan(
                          text: 'Kebijakan Privasi.',
                          style: TextStyle(color: AppColors.softPink),
                        ),
                      ],
                    ),
                  ),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                ),
              ),
            ],
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
                  showToast(context, state.message);
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
                      ? (loading ? () => {} : () => context.read<AuthBloc>().add(RegisterEvent(formRegister)))
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
                      : const Text('Kirim Data', style: TextStyle(fontSize: 20)),
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
