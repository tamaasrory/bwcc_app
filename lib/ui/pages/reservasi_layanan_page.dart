import 'dart:convert';

import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/bloc/res_layanan_bloc.dart';
import 'package:bwcc_app/bloc/reservasi_bloc.dart' as reserva;
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/models/reservasi_layanan.dart';
import 'package:bwcc_app/models/select.dart';
import 'package:bwcc_app/models/user.dart';
import 'package:bwcc_app/ui/pages/detail_reservasi_page.dart';
import 'package:bwcc_app/ui/widgets/color_full_label.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:bwcc_app/ui/widgets/dropdown.dart';
import 'package:bwcc_app/ui/widgets/text_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservasiLayananPage extends StatefulWidget {
  final String? layananId;

  const ReservasiLayananPage({Key? key, this.layananId}) : super(key: key);

  @override
  State<ReservasiLayananPage> createState() => _ReservasiLayananPageState();
}

class _ReservasiLayananPageState extends State<ReservasiLayananPage> {
  bool loadImgProfile = false;
  bool ditemukan = false;
  bool loading = false;

  ReservasiLayanan formReservasi = ReservasiLayanan();
  String selectedHari = 'null';
  List _tglAvailable = [];
  DateTime? initialSelectHari;
  DateTime? initialTglLahir;

  List<Select> _pilihanLayanan = [
    Select(text: 'PILIH LAYANAN', value: 'null'),
  ];

  List<Select> _pilihanWaktu = [
    Select(text: 'PILIH WAKTU', value: 'null'),
  ];

  List<Pasien> _pilihanPasien = [
    Pasien(text: 'PILIH PASIEN', value: 'null'),
  ];

  @override
  initState() {
    BlocProvider.of<ResLayananBloc>(context).add(GetLayananEvent());
    BlocProvider.of<reserva.ReservasiBloc>(context).add(reserva.GetDaftarKeluargaEvent());
    if (mounted) {
      formReservasi.kuotaLayananId = 'null';
      formReservasi.idLayanan = 'null';
      formReservasi.nama = 'null';
      initialTglLahir = DateTime.now();

      getUser().then((value) {
        formReservasi.namaPenanggungjawab = value.username;
        formReservasi.email = value.email;
        logApp('npj => ' + formReservasi.namaPenanggungjawab.toString());
        setState(() {});
      });
    }
    super.initState();
  }

  _isValid() {
    return true;
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
                      'RESERVASI LAYANAN',
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
                    BlocListener<ResLayananBloc, ResLayananState>(
                      listener: (context, state) {
                        if (state is ResultGetLayananState) {
                          if (state.data.isNotEmpty) {
                            _pilihanLayanan = [
                              Select(text: 'PILIH LAYANAN', value: 'null'),
                            ];
                            _pilihanLayanan.addAll(state.data);
                            setState(() {});
                            if (widget.layananId.toString() != 'null') {
                              BlocProvider.of<ResLayananBloc>(context).add(
                                GetHariReservasiEvent(layanan: widget.layananId.toString()),
                              );
                              formReservasi.idLayanan = widget.layananId;
                              setState(() {});
                            } 
                          }
                        }
                      },
                      child: SelectWidget(
                        label: const ['Pilih ', 'Layanan'],
                        value: formReservasi.idLayanan,
                        items: _pilihanLayanan.map((e) => e.toJson()).toList(),
                        onChanged: (newValue) {
                          BlocProvider.of<ResLayananBloc>(context).add(
                            GetHariReservasiEvent(layanan: newValue.toString()),
                          );
                          formReservasi.hari = 'null';
                          formReservasi.idLayanan = newValue.toString();
                          initialSelectHari = null;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    richLable(context, 'Pilih ', 'Hari'),
                    BlocListener<ResLayananBloc, ResLayananState>(
                      listener: (context, state) {
                        if (state is ResultGetHariState) {
                          if (state.data.isNotEmpty) {
                            _tglAvailable = [];
                            _tglAvailable.addAll(state.data);
                            // if (_tglAvailable.isNotEmpty) {
                            initialSelectHari = DateTime.parse(_tglAvailable[0]);
                            // }
                            setState(() {});
                          }
                        }
                      },
                      child: DateTimePicker(
                        key: ObjectKey(initialSelectHari),
                        type: DateTimePickerType.date,
                        locale: const Locale('id'),
                        dateMask: 'dd/MMM/yyyy',
                        initialValue: null,
                        readOnly: initialSelectHari == null ? true : false,
                        initialDate: initialSelectHari,
                        dateHintText: 'Pilih Hari',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        selectableDayPredicate: (date) {
                          logApp('$_tglAvailable || ' + date.toString());
                          // Disable weekend days to select from the calendar
                          if (_tglAvailable.contains(date.toString().substring(0, 10))) {
                            return true;
                          }

                          return false;
                        },
                        onChanged: (val) {
                          BlocProvider.of<ResLayananBloc>(context).add(GetWaktuReservasiEvent(
                            layanan: formReservasi.idLayanan.toString(),
                            hari: val,
                          ));
                          formReservasi.hari = val;
                          setState(() {
                            selectedHari = val;
                          });
                        },
                        validator: (val) {
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocListener<ResLayananBloc, ResLayananState>(
                      listener: (context, state) {
                        if (state is ResultGetWaktuState) {
                          if (state.data.isNotEmpty) {
                            formReservasi.kuotaLayananId = 'null';
                            _pilihanWaktu = [
                              Select(text: 'PILIH WAKTU', value: 'null'),
                            ];
                            _pilihanWaktu.addAll(state.data);
                            setState(() {});
                          }
                        }
                      },
                      child: SelectWidget(
                        label: const ['Pilih ', 'Waktu'],
                        value: formReservasi.kuotaLayananId,
                        items: _pilihanWaktu.map((e) => e.toJson()).toList(),
                        onChanged: (newValue) {
                          formReservasi.kuotaLayananId = newValue.toString();
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      key: ObjectKey(formReservasi.namaPenanggungjawab),
                      customelabel: richLable(context, 'Nama ', 'Penanggung Jawab'),
                      hint: 'Masukkan nama Penanggung Jawab',
                      value: formReservasi.namaPenanggungjawab,
                      readonly: true,
                      onChanged: (newValue) {
                        formReservasi.namaPenanggungjawab = newValue.toString();
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocListener<reserva.ReservasiBloc, reserva.ReservasiState>(
                      listener: (context, state) {
                        if (state is reserva.ResultGetDaftarKeluargaState) {
                          if (state.data.isNotEmpty) {
                            _pilihanPasien = [
                              Pasien(text: 'PILIH PASIEN', value: 'null'),
                            ];
                            _pilihanPasien.addAll(state.data);
                            setState(() {});
                          }
                        }
                      },
                      child: SelectWidget(
                        label: const ['Pilih ', 'Pasien'],
                        value: formReservasi.nama,
                        items: _pilihanPasien.map((e) => e.toJson()).toList(),
                        onChanged: (newValue) {
                          formReservasi.nama = newValue.toString();
                          var tmp = getValue(_pilihanPasien, formReservasi.nama) as Pasien;
                          initialTglLahir = DateTime.parse(tmp.tglLahir.toString());
                          formReservasi.tglLahir = tmp.tglLahir.toString();
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    richLable(context, 'Tanggal Lahir ', 'Pasien'),
                    TextFieldWidget(
                      key: ObjectKey(formReservasi.tglLahir),
                      hint: 'Pilih Tanggal Lahir',
                      value: AppDateTime(formReservasi.tglLahir).format('dd/MMM/yyyy'),
                      readonly: true,
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      customelabel: richLable(context, 'Catatan ', ''),
                      hint: 'Masukkan Catatan',
                      onChanged: (v) {
                        formReservasi.note = v.toString();
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: BlocListener<ResLayananBloc, ResLayananState>(
                        listener: (context, state) {
                          if (state is ProgessState) {
                            loading = state.loading;
                            if (!state.loading) {
                              Future.delayed(const Duration(milliseconds: 1250), () {
                                setState(() {});
                                if (state.extra != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailReservasiPage(
                                        noReservasi: state.extra.toString(),
                                        isFromReservasi: true,
                                      ),
                                    ),
                                  );
                                } else {
                                  dialogInfo(
                                    context,
                                    title: 'Gagal Melakukan Reservasi',
                                    messages:
                                        'Serpertinya ada masalah, silahkan coba ulang beberapa saat lagi',
                                  );
                                }
                              });
                            } else {
                              setState(() {});
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
                                      logApp('HASIL FORM DATA => ' + jsonEncode(formReservasi.toJson()));
                                      formReservasi.jamWaktu = getValue(
                                        _pilihanWaktu,
                                        formReservasi.kuotaLayananId.toString(),
                                      ).text;
                                      setState(() {});
                                      BlocProvider.of<ResLayananBloc>(context)
                                          .add(PostReservasiEvent(formReservasi));
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
                                  'Buat Jadwal Reservasi',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
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
