import 'package:bwcc_app/bloc/profile_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/ui/pages/detail_keluarga_page.dart';
import 'package:bwcc_app/ui/pages/tambah_keluarga_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaftarKeluargaPage extends StatefulWidget {
  const DaftarKeluargaPage({Key? key}) : super(key: key);

  @override
  State<DaftarKeluargaPage> createState() => _DaftarKeluargaPageState();
}

class _DaftarKeluargaPageState extends State<DaftarKeluargaPage> {
  @override
  initState() {
    BlocProvider.of<ProfileBloc>(context).add(GetDaftarKeluargaEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 40),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahKeluargaPage(
                data: Pasien(
                  golonganDarah: 'null',
                  provinsi: 'null',
                  kabKota: 'null',
                  kecamatan: 'null',
                  desa: 'null',
                ),
              ),
            ),
          );
          BlocProvider.of<ProfileBloc>(context).add(GetDaftarKeluargaEvent());
        },
      ),
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
                      'DAFTAR KELUARGA',
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
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        List<Pasien>? data = state is ResultDaftarKeluargaState ? state.data : null;
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
                                          builder: (context) => DetailKeluargaPage(
                                            data: v,
                                          ),
                                        ),
                                      );
                                      BlocProvider.of<ProfileBloc>(context).add(GetDaftarKeluargaEvent());
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 10,
                                          left: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(color: HexColor('#f5f5f5'), width: 1.5),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 4, color: HexColor('#eeeeee')),
                                                borderRadius: BorderRadius.circular(100),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.6),
                                                    offset: const Offset(0.0, 2.0),
                                                    blurRadius: 5,
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: v.avatar != null
                                                    ? Image.network(
                                                        Urls.getStorage(v.avatar!),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        'assets/images/banner-1.jpg',
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 20,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Text(
                                                      v.nama.toString(),
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Lahir : ' +
                                                          AppDateTime(v.tglLahir).format('dd MMM yyyy'),
                                                      style: TextStyle(color: HexColor('#888888')),
                                                    ),
                                                    Text(
                                                      'Umur : ${v.umur.toString()} Tahun',
                                                      style: TextStyle(color: HexColor('#888888')),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
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
        ],
      ),
    );
  }
}
