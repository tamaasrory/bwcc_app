import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/bloc/bottom_navbar_bloc.dart';
import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/riwayat_reservasi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailArtikelPage extends StatefulWidget {
  final String slug;
  const DetailArtikelPage({Key? key, required this.slug}) : super(key: key);

  @override
  State<DetailArtikelPage> createState() => _DetailArtikelPageState();
}

class _DetailArtikelPageState extends State<DetailArtikelPage> {
  bool loadImgProfile = false;

  @override
  initState() {
    BlocProvider.of<BerandaBloc>(context).add(GetDetailRiwayatEvent(widget.slug));
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
                        Navigator.pop(context, false);
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
                child: BlocBuilder<ReservasiBloc, ReservasiState>(
                  builder: (context, state) {
                    RiwayatReservasi? data = state is ResultDetailRiwayatState ? state.data : null;
                    return data != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                'Hai ${data.nama}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Terima kasih telah melakukan reservasi di BWCC\ndengan detail sebagai berikut:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 23,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Nomor Reservasi : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Theme.of(context).colorScheme.secondary),
                                      ),
                                      child: Text(
                                        data.noReservasi.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: (() {
                                        Clipboard.setData(
                                          ClipboardData(text: data.noReservasi.toString()),
                                        ).then((value) {
                                          showToast(context, 'Nomor reservasi telah tercopy',
                                              position: MediaQuery.of(context).size.height - 100);
                                        });
                                      }),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.copy,
                                            size: 18,
                                          ),
                                          Text('Copy')
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                'Nama Poli : ${data.poli}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Nama Dokter : ${data.dokter}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Jadwal : ${AppDateTime(data.hari).format('dd MMM yyyy')}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Waktu : ${data.jam}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Admin Pendaftaran : ${data.feePendaftaran}\n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '''${data.additional}''',
                                style: const TextStyle(
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
                                    BlocProvider.of<BottomNavbarBloc>(context)
                                        .add(const BottomNavbarEvent(2));
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
                          )
                        : const Center(
                            child: Text('Data tidak ditemukan'),
                          );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
