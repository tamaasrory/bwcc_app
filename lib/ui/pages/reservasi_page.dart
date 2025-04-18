import 'dart:convert';

import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/bloc/bottom_navbar_bloc.dart';
import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/form_reservasi.dart';
import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/models/select.dart';
import 'package:bwcc_app/models/user.dart';
import 'package:bwcc_app/ui/widgets/color_full_label.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:bwcc_app/ui/widgets/dropdown.dart';
import 'package:bwcc_app/ui/widgets/text_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservasiPage extends StatefulWidget {
  final String? poliId;
  final String? dokterId;

  const ReservasiPage({Key? key, this.dokterId, this.poliId}) : super(key: key);

  @override
  State<ReservasiPage> createState() => _ReservasiPageState();
}

class _ReservasiPageState extends State<ReservasiPage> {
  bool loadImgProfile = false;
  bool ditemukan = false;
  bool loading = false;

  FormReservasi formReservasi = FormReservasi();
  String selectedHari = 'null';
  List _tglAvailable = [];
  DateTime? initialSelectHari;
  DateTime? initialTglLahir;

  List<Select> _pilihanPoli = [
    Select(text: 'PILIH POLI', value: 'null'),
  ];

  List<Select> _pilihanDokter = [
    Select(text: 'PILIH DOKTER', value: 'null'),
  ];

  List<Select> _pilihanWaktu = [
    Select(text: 'PILIH WAKTU', value: 'null'),
  ];

  List<Select> _pilihanPayment = [
    Select(text: 'PILIH JENIS PEMBAYARAN', value: 'null'),
  ];

  List<Pasien> _pilihanPasien = [
    Pasien(text: 'PILIH PASIEN', value: 'null'),
  ];

  @override
  initState() {
    BlocProvider.of<ReservasiBloc>(context).add(GetPoliEvent());
    BlocProvider.of<ReservasiBloc>(context).add(GetMetodePembayaranEvent());
    BlocProvider.of<ReservasiBloc>(context).add(GetDaftarKeluargaEvent());
    if (mounted) {
      formReservasi.kuotaId = 'null';
      formReservasi.nama = 'null';
      formReservasi.nik = 'null';
      formReservasi.asuransiId = 'null';
      if (widget.dokterId.toString() == 'null') {
        formReservasi.dokterId = 'null';
      }
      initialTglLahir = DateTime.now();
      setState(() {});
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
    var _state = BlocProvider.of<AuthBloc>(context).state;
    AuthAttampState authState = (_state is AuthAttampState) ? _state : AuthAttampState(data: User());
    formReservasi.namaPenanggungjawab = authState.data.username;

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
                      'RESERVASI',
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
                    BlocListener<ReservasiBloc, ReservasiState>(
                      listener: (context, state) {
                        if (state is ResultGetPoliState) {
                          if (state.data.isNotEmpty) {
                            _pilihanPoli = [
                              Select(text: 'PILIH POLI', value: 'null'),
                            ];
                            _pilihanPoli.addAll(state.data);
                            formReservasi.poliId =
                                getValue(state.data, widget.poliId.toString(), asBool: true)
                                    ? widget.poliId.toString()
                                    : 'null';
                            setState(() {});
                            if (formReservasi.poliId != 'null') {
                              BlocProvider.of<ReservasiBloc>(context).add(
                                GetDokterReservasiEvent(
                                  poliId: formReservasi.poliId.toString(),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: SelectWidget(
                        label: const ['Pilih ', 'Poli'],
                        value: formReservasi.poliId,
                        items: _pilihanPoli.map((e) => e.toJson()).toList(),
                        itemText: (v) =>
                            (v['text'] as String).contains('POLI') ? v['text'] : 'POLI ' + v['text'],
                        onChanged: (newValue) {
                          BlocProvider.of<ReservasiBloc>(context).add(
                            GetDokterReservasiEvent(
                              poliId: newValue.toString(),
                            ),
                          );
                          formReservasi.dokterId = 'null';
                          formReservasi.poliId = newValue.toString();
                          initialSelectHari = null;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocListener<ReservasiBloc, ReservasiState>(
                      listener: (context, state) {
                        if (state is ResultGetDokterState) {
                          if (state.data.isNotEmpty) {
                            _pilihanDokter = [
                              Select(text: 'PILIH DOKTER', value: 'null'),
                            ];
                            _pilihanDokter.addAll(state.data);
                            formReservasi.dokterId =
                                getValue(state.data, widget.dokterId.toString(), asBool: true)
                                    ? widget.dokterId.toString()
                                    : 'null';
                            setState(() {});
                            if (formReservasi.dokterId != 'null') {
                              BlocProvider.of<ReservasiBloc>(context).add(
                                GetHariReservasiEvent(
                                  dokId: formReservasi.dokterId.toString(),
                                  poliId: formReservasi.poliId.toString(),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: SelectWidget(
                        label: const ['Pilih ', 'Dokter'],
                        value: formReservasi.dokterId,
                        items: _pilihanDokter.map((e) => e.toJson()).toList(),
                        onChanged: (newValue) {
                          BlocProvider.of<ReservasiBloc>(context).add(GetHariReservasiEvent(
                            dokId: newValue.toString(),
                            poliId: formReservasi.poliId.toString(),
                          ));
                          formReservasi.dokterId = newValue.toString();
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    richLable(context, 'Pilih ', 'Hari'),
                    BlocListener<ReservasiBloc, ReservasiState>(
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
                          BlocProvider.of<ReservasiBloc>(context).add(GetWaktuReservasiEvent(
                            dokId: formReservasi.dokterId.toString(),
                            poliId: formReservasi.poliId.toString(),
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
                    BlocListener<ReservasiBloc, ReservasiState>(
                      listener: (context, state) {
                        if (state is ResultGetWaktuState) {
                          if (state.data.isNotEmpty) {
                            formReservasi.kuotaId = 'null';
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
                        value: formReservasi.kuotaId,
                        items: _pilihanWaktu.map((e) => e.toJson()).toList(),
                        onChanged: (newValue) {
                          formReservasi.kuotaId = newValue.toString();
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
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
                    BlocListener<ReservasiBloc, ReservasiState>(
                      listener: (context, state) {
                        if (state is ResultGetDaftarKeluargaState) {
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
                          formReservasi.nik = tmp.nik.toString();
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
                    const SizedBox(height: 15),
                    richLable(context, 'Nomor ', 'KTP / KAI'),
                    TextFieldWidget(
                      key: ObjectKey(formReservasi.nik),
                      hint: 'Nomor KTP atau KAI (jika pasien anak)',
                      value: formReservasi.nik.toString() != 'null' ? formReservasi.nik : null,
                      readonly: true,
                    ),
                    const SizedBox(height: 15),
                    BlocListener<ReservasiBloc, ReservasiState>(
                      listener: (context, state) {
                        if (state is ResultGetMetodePembayaranState) {
                          if (state.data.isNotEmpty) {
                            _pilihanPayment = [
                              Select(text: 'PILIH JENIS PEMBAYARAN', value: 'null'),
                            ];
                            _pilihanPayment.addAll(state.data);
                            setState(() {});
                          }
                        }
                      },
                      child: SelectWidget(
                        label: const ['Jenis ', 'Pembayaran'],
                        value: formReservasi.asuransiId,
                        items: _pilihanPayment.map((e) => e.toJson()).toList(),
                        onChanged: (newValue) {
                          formReservasi.asuransiId = newValue.toString();
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      customelabel: richLable(context, 'Keluhan ', 'Awal'),
                      hint: 'Masukkan keluhan awal',
                      onChanged: (v) {
                        formReservasi.note = v.toString();
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: BlocListener<ReservasiBloc, ReservasiState>(
                        listener: (context, state) {
                          if (state is ProgessState) {
                            loading = state.loading;
                            if (!state.loading) {
                              Future.delayed(const Duration(milliseconds: 1250), () {
                                setState(() {});
                                if (state.extra != null) {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => DetailReservasiPage(
                                  //       noReservasi: state.extra.toString(),
                                  //       isFromReservasi: true,
                                  //     ),
                                  //   ),
                                  // );
                                  BlocProvider.of<BottomNavbarBloc>(context).add(
                                    BottomNavbarEvent(2, data: {'noReservasi': state.extra.toString()}),
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
                                      formReservasi.phone = authState.data.noHandphone;
                                      formReservasi.email = authState.data.email;
                                      formReservasi.jamWaktu =
                                          getValue(_pilihanWaktu, formReservasi.kuotaId.toString()).text;
                                      setState(() {});
                                      BlocProvider.of<ReservasiBloc>(context)
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
