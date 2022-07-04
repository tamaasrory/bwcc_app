import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/dokter.dart';
import 'package:bwcc_app/models/select.dart';
import 'package:bwcc_app/ui/pages/profile_dokter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/dropdown.dart';

class CariDokterPage extends StatefulWidget {
  const CariDokterPage({Key? key}) : super(key: key);

  @override
  State<CariDokterPage> createState() => _CariDokterPageState();
}

class _CariDokterPageState extends State<CariDokterPage> {
  bool loadImgProfile = false;
  bool ditemukan = false;
  bool loading = false;

  String selectedPoli = '-1';
  final List<Select> _pilihanPoli = [
    Select(text: 'SEMUA POLI', value: '-1'),
  ];

  String selectedHari = '-1';
  final List<Select> _pilihanHari = [
    Select(text: 'SEMUA HARI', value: '-1'),
    Select(text: 'SENIN', value: 'SENIN'),
    Select(text: 'SELASA', value: 'SELASA'),
    Select(text: 'RABU', value: 'RABU'),
    Select(text: 'KAMIS', value: 'KAMIS'),
    Select(text: 'JUMAT', value: 'JUMAT'),
    Select(text: 'SABTU', value: 'SABTU'),
    Select(text: 'MINGGU', value: 'MINGGU'),
  ];

  List<Dokter>? datas;
  List<Widget>? riwayatPencarian;

  @override
  initState() {
    BlocProvider.of<ReservasiBloc>(context).add(GetPoliEvent());
    if (mounted) {
      getRiwayatCari();
    }
    super.initState();
  }

  getText(List<dynamic> data, val) {
    int index = data.indexWhere((element) => element.value == val);
    return data[index].text;
  }

  Future<List<String>?> getRiwayatCari() async {
    List<String>? data = await getData<List<String>>('pref_riwayatcari');
    if (data != null) {
      riwayatPencarian = data.reversed.map((e) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              e,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList();
    } else {
      riwayatPencarian = null;
    }
    setState(() {});
    return data;
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
                        if (!ditemukan) {
                          Navigator.pop(context, false);
                        }
                        ditemukan = false;
                        setState(() {});
                      },
                      child: Image.asset(AppAssets.backWhite, width: 32, height: 32),
                    ),
                    const Text(
                      'DOKTER KAMI',
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
              child: ditemukan
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'DOKTER POLI ',
                                ),
                                TextSpan(
                                  text: getText(_pilihanPoli, selectedPoli),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                const TextSpan(
                                  text: ';  HARI ',
                                ),
                                TextSpan(
                                  text: getText(_pilihanHari, selectedHari),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(height: 5),
                        BlocBuilder<ReservasiBloc, ReservasiState>(
                          builder: (context, state) {
                            if (state is ResultCariDokterState) {
                              datas = state.data;
                              if (datas != null) {
                                return ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(10),
                                  shrinkWrap: true,
                                  children: datas!.map((v) {
                                    return GestureDetector(
                                      onTap: () async {
                                        List<String>? prefRC =
                                            await getData<List<String>>('pref_riwayatcari');
                                        if (prefRC != null) {
                                          prefRC.add(v.nama.toString());
                                          await saveData<List<String>>('pref_riwayatcari', prefRC);
                                        } else {
                                          await saveData<List<String>>(
                                            'pref_riwayatcari',
                                            [v.nama.toString()],
                                          );
                                        }
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProfileDokterPage(
                                              dokterId: v.id!,
                                              poliId: selectedPoli.toString(),
                                            ),
                                          ),
                                        );
                                        context.read<ReservasiBloc>().add(CariDokterEvent(
                                              poliId: selectedPoli,
                                              hari: selectedHari.toLowerCase(),
                                            ));
                                        getRiwayatCari();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey,
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 5),
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2, color: HexColor('#eeeeee')),
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
                                                              : const Icon(
                                                                  Icons.account_circle,
                                                                  size: 45,
                                                                  color: Colors.grey,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          v.nama.toString(),
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Theme.of(context).colorScheme.primary,
                                                          ),
                                                        ),
                                                        SizedBox(height: v.spesialis != null ? 3 : 0),
                                                        v.spesialis != null
                                                            ? Text(
                                                                v.spesialis.toString(),
                                                                style: TextStyle(
                                                                  color:
                                                                      Theme.of(context).colorScheme.secondary,
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Image.asset(
                                                      v.icon.toString(),
                                                      width: 48,
                                                      height: 48,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              child: Text(
                                'Tidak ada jadwal yang ditemukan, Silahkan coba lagi nanti',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocListener<ReservasiBloc, ReservasiState>(
                            listener: (context, state) {
                              if (state is ResultGetPoliState) {
                                if (state.data.isNotEmpty) {
                                  _pilihanPoli.addAll(state.data);
                                  setState(() {});
                                }
                              }
                            },
                            child: SelectWidget(
                              label: const ['Pilih ', 'Poli'],
                              value: selectedPoli,
                              // Array list of items
                              items: _pilihanPoli.map((e) => e.toJson()).toList(),
                              itemText: (v) =>
                                  (v['text'] as String).contains('POLI') ? v['text'] : 'POLI ' + v['text'],
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                setState(() {
                                  selectedPoli = newValue.toString();
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          SelectWidget(
                            label: const ['Pilih ', 'Hari'],
                            value: selectedHari,
                            // Array list of items
                            items: _pilihanHari.map((e) => e.toJson()).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (newValue) {
                              setState(() {
                                selectedHari = newValue.toString();
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            child: BlocListener<ReservasiBloc, ReservasiState>(
                              listener: (context, state) {
                                if (state is ProgessState) {
                                  loading = state.loading;
                                  if (!state.loading) {
                                    Future.delayed(const Duration(milliseconds: 1250), () {
                                      setState(() {
                                        ditemukan = true;
                                      });
                                    });
                                  } else {
                                    setState(() {});
                                  }
                                }
                              },
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: loading
                                    ? () => {}
                                    : () {
                                        context.read<ReservasiBloc>().add(CariDokterEvent(
                                              poliId: selectedPoli,
                                              hari: selectedHari.toLowerCase(),
                                            ));
                                      },
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
                                          Text('Sedang Mencari', style: TextStyle(fontSize: 20))
                                        ],
                                      )
                                    : const Text('Cari', style: TextStyle(fontSize: 20)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Riwayat Pencarian',
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await removeData('pref_riwayatcari');
                                  getRiwayatCari();
                                },
                                child: const Text('Bersihkan'),
                              )
                            ],
                          ),
                          SizedBox(
                            key: ObjectKey(riwayatPencarian),
                            child: riwayatPencarian != null
                                ? ListView(
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    children: riwayatPencarian!,
                                  )
                                : const SizedBox(
                                    height: 150,
                                    child: Center(
                                      child: Text(
                                        'KOSONG',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
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
