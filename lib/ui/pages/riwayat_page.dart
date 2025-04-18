import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/riwayat_reservasi.dart';
import 'package:bwcc_app/ui/pages/detail_reservasi_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiwayatPage extends StatefulWidget {
  final dynamic data;
  const RiwayatPage({Key? key, this.data}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  bool loadImgProfile = false;

  @override
  initState() {
    if (widget.data != null) {
      if (widget.data['noReservasi'].toString() != 'null') {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailReservasiPage(
                noReservasi: widget.data['noReservasi'].toString(),
                isFromReservasi: false,
              ),
            ),
          );
          widget.data['noReservasi'] = 'null';
          BlocProvider.of<ReservasiBloc>(context).add(GetRiwayatEvent());
        });
      } else {
        BlocProvider.of<ReservasiBloc>(context).add(GetRiwayatEvent());
      }
    } else {
      BlocProvider.of<ReservasiBloc>(context).add(GetRiwayatEvent());
    }
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
                      'RIWAYAT',
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
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<ReservasiBloc>(context).add(GetRiwayatEvent());
              },
              child: SingleChildScrollView(
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<ReservasiBloc, ReservasiState>(
                        builder: (context, state) {
                          List<RiwayatReservasi>? data =
                              state is ResultRiwayatReservasiState ? state.data : null;
                          return data != null
                              ? ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(10),
                                  shrinkWrap: true,
                                  children: data.map((v) {
                                    return GestureDetector(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailReservasiPage(
                                              noReservasi: v.noReservasi.toString(),
                                              isFromReservasi: false,
                                            ),
                                          ),
                                        );
                                        BlocProvider.of<ReservasiBloc>(context).add(GetRiwayatEvent());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey,
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(7)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                IntrinsicHeight(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        v.noReservasi.toString(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).colorScheme.secondary,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        AppDateTime(v.createdAt.toString())
                                                            .format('EEEE, dd MMM yyyy HH:mm')
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).colorScheme.primary,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  v.layanan == 'null'
                                                      ? '${v.nama}; ${v.poli}; ${v.dokter}'
                                                      : '${v.nama}; Layanan: ${v.layanan};',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  v.statuskonfirm.toString() != 'null'
                                                      ? v.statuskonfirm.toString()
                                                      : 'MENUNGGU KONFIRMASI PEMBAYARAN ANDA',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Colors.amber[800],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                              : const Center(child: Text('Belum ada riwayat reservasi'));
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
