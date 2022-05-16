import 'dart:io';

import 'package:bwcc_app/bloc/bottom_navbar_bloc.dart';
import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/riwayat_reservasi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailReservasiPage extends StatefulWidget {
  final String noReservasi;
  final bool isFromReservasi;
  const DetailReservasiPage({Key? key, required this.noReservasi, required this.isFromReservasi})
      : super(key: key);

  @override
  State<DetailReservasiPage> createState() => _DetailReservasiPageState();
}

class _DetailReservasiPageState extends State<DetailReservasiPage> {
  bool loadImgProfile = false;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  initState() {
    BlocProvider.of<ReservasiBloc>(context).add(GetDetailRiwayatEvent(widget.noReservasi));
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
                        if (widget.isFromReservasi) {
                          BlocProvider.of<BottomNavbarBloc>(context).add(const BottomNavbarEvent(2));
                        } else {
                          Navigator.pop(context, false);
                        }
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
                                    const SizedBox(width: 5),
                                    TextButton(
                                      onPressed: (() {
                                        Clipboard.setData(
                                          ClipboardData(text: data.noReservasi.toString()),
                                        ).then((value) {
                                          showToast(
                                            context,
                                            'Nomor reservasi telah tercopy',
                                            position: 50,
                                          );
                                        });
                                      }),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(0, 0),
                                      ),
                                      child: Wrap(
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
                                'Admin Pendaftaran : ' +
                                    NumberFormat.currency(locale: 'id').format(data.feePendaftaran),
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
                                  onPressed: () async {
                                    // final ImagePicker _picker = ImagePicker();
                                    // // Pick an image
                                    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                    // // Capture a photo
                                    // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        // Using Wrap makes the bottom sheet height the height of the content.
                                        // Otherwise, the height will be half the height of the screen.
                                        return Wrap(
                                          children: [
                                            Container(
                                              color: HexColor('#f5f5f5'),
                                              width: MediaQuery.of(context).size.width,
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 15,
                                                horizontal: 20,
                                              ),
                                              child: const Text(
                                                'Kirim Foto bukti transfer anda',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                // Pick an image
                                                final XFile? image =
                                                    await _picker.pickImage(source: ImageSource.gallery);
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                minimumSize: const Size(0, 0),
                                              ),
                                              child: const ListTile(
                                                leading: Icon(Icons.image),
                                                title: Text('Ambil dari Gallery'),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                // Capture a photo
                                                final XFile? photo =
                                                    await _picker.pickImage(source: ImageSource.camera);
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                minimumSize: const Size(0, 0),
                                              ),
                                              child: const ListTile(
                                                leading: Icon(Icons.camera_alt),
                                                title: Text('Foto dari Kamera'),
                                              ),
                                            ),
                                            const SizedBox(height: 70),
                                          ],
                                        );
                                      },
                                    );
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
                              Center(
                                child: ElevatedButton(
                                  child: const Text('Select An Image'),
                                  onPressed: _openImagePicker,
                                ),
                              ),
                              const SizedBox(height: 35),
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 300,
                                color: Colors.grey[300],
                                child: _image != null
                                    ? Image.file(_image!, fit: BoxFit.cover)
                                    : const Text('Please select an image'),
                              ),
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
