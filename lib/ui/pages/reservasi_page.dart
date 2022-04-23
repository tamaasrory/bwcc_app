import 'package:bwcc_app/bloc/bottom_navbar_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/pages/jadwal_page.dart';
import 'package:bwcc_app/ui/widgets/color_full_label.dart';
import 'package:bwcc_app/ui/widgets/dropdown.dart';
import 'package:bwcc_app/ui/widgets/text_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservasiPage extends StatefulWidget {
  const ReservasiPage({Key? key}) : super(key: key);

  @override
  State<ReservasiPage> createState() => _ReservasiPageState();
}

class _ReservasiPageState extends State<ReservasiPage> {
  bool loadImgProfile = false;
  bool ditemukan = false;
  String selectedPoli = 'null';
  final _pilihanPoli = [
    {"text": "PILIH POLI", "value": "null"},
    {'text': 'ANAK SAKIT', 'value': 'ANAK SAKIT'},
    {'text': 'ANAK SEHAT', 'value': 'ANAK SEHAT'},
    {'text': 'OBGYN', 'value': 'OBGYN'},
    {'text': 'ZYGOTE (KLINIK INFERTILITAS)', 'value': 'ZYGOTE (KLINIK INFERTILITAS)'},
    {'text': 'GIGI', 'value': 'GIGI'},
    {'text': 'LAKTASI', 'value': 'LAKTASI'},
    {'text': 'GIZI', 'value': 'GIZI'},
    {'text': 'KULIT DAN KELAMIN', 'value': 'KULIT DAN KELAMIN'},
    {'text': 'TELEMEDICINE', 'value': 'TELEMEDICINE'},
  ];
  String selectedDokter = 'null';
  final _pilihanDokter = [
    {"text": "PILIH DOKTER", "value": "null"},
    {"text": "dr. Andini Striratriputri, SpA", "value": "1"},
    {"text": "dr. Angelina, SpA", "value": "2"},
    {"text": "dr. Datu B. Irawati, SpA", "value": "3"},
    {"text": "dr. Dwi Kartika, SpA", "value": "4"},
    {"text": "dr. Handoko Lowis, SpA", "value": "5"},
    {"text": "dr. Henni Wahyu Triyuniati, SpA", "value": "6"},
    {"text": "dr. Herwasto Jatmiko, SpA", "value": "7"},
    {"text": "dr. Liza Meilany, SpA", "value": "8"},
    {"text": "dr. Naela Fadhila, SpA", "value": "9"},
    {"text": "dr. Novitria Dwinanda, SpA (K)", "value": "10"},
    {"text": "dr. Ratih Puspita, SpA", "value": "11"},
    {"text": "dr. Rizki Aryo Wicaksono, M.Ked(Paed), SpA", "value": "12"},
    {"text": "dr. Shita P. Abe, SpA", "value": "13"},
    {"text": "dr. Srihati Dyah P, SpA", "value": "43"},
  ];
  String selectedHari = 'null';
  final _pilihanHari = [
    {'text': 'PILIH HARI', 'value': 'null'},
    {'text': 'SENIN', 'value': 'SENIN'},
    {'text': 'SELASA', 'value': 'SELASA'},
    {'text': 'RABU', 'value': 'RABU'},
    {'text': 'KAMIS', 'value': 'KAMIS'},
    {'text': 'JUMAT', 'value': 'JUMAT'},
    {'text': 'SABTU', 'value': 'SABTU'},
    {'text': 'MINGGU', 'value': 'MINGGU'},
  ];

  String selectedWaktu = 'null';
  final _pilihanWaktu = [
    {'text': 'PILIH WAKTU', 'value': 'null'},
    {'text': '16.00 - 17.00', 'value': '16.00 - 17.00'},
    {'text': '17.00 - 18.00', 'value': '17.00 - 18.00'},
  ];
  String selectedPayment = 'null';
  final _pilihanPayment = [
    {'text': 'PILIH JENIS PEMBAYARAN', 'value': 'null'},
    {'text': 'ASURANSI', 'value': 'ASURANSI'},
    {'text': 'PRIBADI', 'value': 'PRIBADI'},
  ];

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
                    dropdownField(
                      context,
                      label: ['Pilih ', 'Poli'],
                      value: selectedPoli,
                      // Array list of items
                      items: _pilihanPoli,
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
                    const SizedBox(height: 10),
                    dropdownField(
                      context,
                      label: ['Pilih ', 'Dokter'],
                      value: selectedDokter,
                      // Array list of items
                      items: _pilihanDokter,
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        setState(() {
                          selectedDokter = newValue.toString();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    dropdownField(
                      context,
                      label: ['Pilih ', 'Hari'],
                      value: selectedHari,
                      // Array list of items
                      items: _pilihanHari,
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        setState(() {
                          selectedHari = newValue.toString();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    dropdownField(
                      context,
                      label: ['Pilih ', 'Waktu'],
                      value: selectedWaktu,
                      // Array list of items
                      items: _pilihanWaktu,
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        setState(() {
                          selectedWaktu = newValue.toString();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    textFieldWidget(
                      context,
                      customelabel: richLable(context, 'Nama ', 'Penanggung Jawab'),
                      hint: 'Masukkan nama Penanggung Jawab',
                      onChanged: (newValue) {
                        setState(() {
                          selectedHari = newValue.toString();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    textFieldWidget(
                      context,
                      customelabel: richLable(context, 'Nama Lengkap ', 'Pasien'),
                      hint: 'Masukkan nama lengkap pasien',
                      onChanged: (newValue) {
                        setState(() {
                          selectedHari = newValue.toString();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    richLable(context, 'Tanggal Lahir ', 'Pasien'),
                    DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'dd/MMM/yyyy',
                      initialValue: DateTime.now().toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      selectableDayPredicate: (date) {
                        // Disable weekend days to select from the calendar
                        if (date.weekday == 6 || date.weekday == 7) {
                          return false;
                        }

                        return true;
                      },
                      onChanged: (val) => print(val),
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                    const SizedBox(height: 15),
                    dropdownField(
                      context,
                      label: ['Jenis ', 'Pembayaran'],
                      value: selectedPayment,
                      // Array list of items
                      items: _pilihanPayment,
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        setState(() {
                          selectedPayment = newValue.toString();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    textFieldWidget(
                      context,
                      customelabel: richLable(context, 'Keluhan ', 'Awal'),
                      hint: 'Masukkan keluhan awal',
                      onChanged: (v) {},
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
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => const JadwalAndaPage()));
                          BlocProvider.of<BottomNavbarBloc>(context).add(const BottomNavbarEvent(1));
                        },
                        child: const Text(
                          'Buat Jadwal Reservasi',
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
