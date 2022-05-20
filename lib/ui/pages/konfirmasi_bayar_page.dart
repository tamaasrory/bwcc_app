import 'dart:io';

import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KonfirmasiBayarPage extends StatefulWidget {
  final String noReservasi;
  final String imagePath;
  const KonfirmasiBayarPage({Key? key, required this.noReservasi, required this.imagePath}) : super(key: key);

  @override
  State<KonfirmasiBayarPage> createState() => _KonfirmasiBayarPageState();
}

class _KonfirmasiBayarPageState extends State<KonfirmasiBayarPage> {
  bool loading = false;
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              color: Theme.of(context).colorScheme.primary,
              child: SafeArea(
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Image.asset(
                          AppAssets.backWhite,
                          width: 32,
                          height: 32,
                        ),
                      ),
                      const Text(
                        'Konfirmasi Pembayaran',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Image.asset(
                        AppAssets.icLogo,
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: SingleChildScrollView(
                child: Image.file(File(widget.imagePath)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: BlocListener<ReservasiBloc, ReservasiState>(
              listener: (context, state) {
                loading = state is ProgessState ? state.loading : false;
                setState(() {});
                if (state is ProgessState) {
                  if (state.extra != null) {
                    Future.delayed(const Duration(milliseconds: 1200), () {
                      Navigator.of(context, rootNavigator: true).pop(false);
                      dialogInfo(context, messages: state.extra.message, actions: [
                        TextButton(
                          onPressed: state.extra.condition
                              ? () {
                                  Navigator.of(context, rootNavigator: true).pop(false);
                                }
                              : () {
                                  Navigator.of(context, rootNavigator: true).pop(false);
                                  context
                                      .read<ReservasiBloc>()
                                      .add(PostKonfirmasiBayarEvent(widget.noReservasi, widget.imagePath));
                                },
                          child: Text(state.extra.condition ? 'Tutup' : 'Kirim Ulang'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop(false);
                          },
                          child: const Text('OK'),
                        ),
                      ]);
                    });
                  } else {
                    dialogInfo(
                      context,
                      title: 'Mengirim Konfirmasi',
                      messages: 'Mohon tunggu sebentar, Sedang mengirim konfirmasi pembayaran anda',
                      dismissable: false,
                    );
                  }
                }
              },
              child: ElevatedButton(
                onPressed: loading
                    ? () {}
                    : () {
                        context
                            .read<ReservasiBloc>()
                            .add(PostKonfirmasiBayarEvent(widget.noReservasi, widget.imagePath));
                      },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
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
                    : Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Text(
                            'KIRIM SEKARANG',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.send)
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
