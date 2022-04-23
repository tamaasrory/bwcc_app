import 'package:bwcc_app/bloc/bottom_navbar_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({Key? key}) : super(key: key);

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
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
                      'JADWAL ANDA',
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
                padding: const EdgeInsets.symmetric(horizontal: 25),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      '''
Hai Citra,
Terima kasih telah melakukan reservasi di BWCC
dengan detail sebagai berikut:\n
Nomor Reservasi : R-11647242761
Nama Poli : Anak
Nama Dokter : dr. Angelina, SpA
Jadwal : 14 Maret 2022
Waktu : 16:00
Admin Pendaftaran : Rp. 33,000\n
Silahkan transfer ke salah satu rekening berikut:\n
Bank: BRI
No Rek: 0206-01-006571-30-6
A/n: BINTARO WOMEN AND CHILDREN CLINIC\n
Bank: BCA
No Rek: 6800-857-153
A/n: PT KASIH AYAH BUNDA MEDIKA\n
Bank: MANDIRI
No Rek: 117-000-7165-582
A/n: PT KASIH AYAH BUNDA MEDIKA
''',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          primary: Theme.of(context).colorScheme.secondary,
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          BlocProvider.of<BottomNavbarBloc>(context).add(const BottomNavbarEvent(2));
                        },
                        child: const Text(
                          'Konfirmasi Pembayaran',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
