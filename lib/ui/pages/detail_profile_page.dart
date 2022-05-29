import 'dart:convert';

import 'package:bwcc_app/bloc/profile_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/user.dart';
import 'package:bwcc_app/ui/widgets/color_full_label.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:bwcc_app/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProfilePage extends StatefulWidget {
  final User data;
  const DetailProfilePage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  bool loading = false;

  _isValid() {
    return true;
  }

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

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                        Navigator.pop(context, false);
                      },
                      child: Image.asset(AppAssets.backWhite, width: 32, height: 32),
                    ),
                    const Text(
                      'UBAH PROFILE',
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
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        right: 10,
                        bottom: 10,
                        left: 10,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(0.0, 2.0),
                              blurRadius: 5,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFieldWidget(
                              customelabel: richLable(context, 'Nama ', 'Lengkap'),
                              hint: 'Nama Lengkap',
                              value: widget.data.username,
                              onChanged: (v) {
                                widget.data.username = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            TextFieldWidget(
                              customelabel: richLable(context, 'No ', 'Handphone'),
                              hint: 'No Handphone',
                              value: widget.data.noHandphone,
                              onChanged: (v) {
                                widget.data.noHandphone = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                              child: BlocListener<ProfileBloc, ProfileState>(
                                listener: (context, state) {
                                  if (state is ProgessState) {
                                    if (state.key == 'update-profile') {
                                      loading = state.loading;
                                      if (!state.loading) {
                                        Future.delayed(const Duration(milliseconds: 1250), () {
                                          setState(() {});
                                          if (state.extra != null) {
                                            dialogInfo(
                                              context,
                                              title: 'Berhasil Menyimpan Perubahan',
                                              messages: 'Data anda berhasil diperbarui, terimakasih',
                                            );
                                          } else {
                                            dialogInfo(
                                              context,
                                              title: 'Gagal Menyimpan Perubahan',
                                              messages:
                                                  'Serpertinya ada masalah, silahkan coba ulang beberapa saat lagi',
                                            );
                                          }
                                        });
                                      } else {
                                        setState(() {});
                                      }
                                    }
                                  }
                                },
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                    primary: Theme.of(context).colorScheme.secondary,
                                    textStyle: const TextStyle(fontSize: 18),
                                  ),
                                  onPressed: _isValid()
                                      ? (loading
                                          ? () {}
                                          : () {
                                              logApp(
                                                'HASIL FORM DATA => ' + jsonEncode(widget.data.toJson()),
                                              );

                                              BlocProvider.of<ProfileBloc>(context)
                                                  .add(PostUpdateProfileEvent(
                                                username: widget.data.username.toString(),
                                                noHp: widget.data.noHandphone.toString(),
                                              ));
                                            })
                                      : null,
                                  child: loading
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(color: Colors.white),
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              'Sedang Mengirim',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        )
                                      : const Text(
                                          'Simpan Perubahan',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
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
