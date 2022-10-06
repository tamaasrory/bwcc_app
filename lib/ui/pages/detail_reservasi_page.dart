import 'package:bwcc_app/bloc/bottom_navbar_bloc.dart';
import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/riwayat_reservasi.dart';
import 'package:bwcc_app/ui/pages/konfirmasi_bayar_page.dart';
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
  final ImagePicker _picker = ImagePicker();

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
                        // // if (widget.isFromReservasi) {
                        // BlocProvider.of<BottomNavbarBloc>(context).add(const BottomNavbarEvent(2));
                        // // } else {
                        Navigator.pop(context, false);
                        // }
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
                              Text(
                                data.statuskonfirm == 'Terdaftar'
                                    ? 'Terima kasih telah melakukan Konfirmasi Pembayaran di BWCC dengan detail sebagai berikut:'
                                    : 'Terima kasih telah melakukan reservasi di BWCC\ndengan detail sebagai berikut:',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              data.statuskonfirm == 'Terdaftar'
                                  ? Text(
                                      'Nomor Antrian : ${data.noAntrian}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 23,
                                child: Row(
                                  children: [
                                    const Text(
                                      'No. Pendaftaran : ',
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
                                    const SizedBox(width: 2),
                                    ElevatedButton(
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
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                        minimumSize: const Size(0, 0),
                                      ),
                                      child: const Text('Salin'),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              (data.layanan != null && data.layanan != 'null')
                                  ? Text(
                                      'Nama Layanan : ${data.layanan}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
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
                                        )
                                      ],
                                    ),
                              const SizedBox(height: 5),
                              Text(
                                'Jadwal : ${AppDateTime(data.hari).format('EEEE, dd MMMM yyyy')}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Waktu : ${data.statuskonfirm != 'Terdaftar' ? data.jam : data.jamakhir}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              data.statuskonfirm != 'Terdaftar'
                                  ? Text(
                                      'Biaya Pendaftaran : ' +
                                          NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0,
                                          ).format(int.parse(data.feePendaftaran!)),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 15),
                              data.statuskonfirm == 'Terdaftar'
                                  ? Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: HexColor('#dddddd'),
                                      ),
                                      child: Text(
                                        data.additional.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red[700],
                                        ),
                                      ),
                                    )
                                  : Text(
                                      '''${data.additional}''',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
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
                                  onPressed: !(['belum terdaftar', 'terdaftar']
                                          .contains(data.statuskonfirm.toString().toLowerCase()))
                                      ? () async {
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
                                                      final XFile? image = await _picker.pickImage(
                                                        source: ImageSource.gallery,
                                                      );

                                                      if (image != null) {
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => KonfirmasiBayarPage(
                                                              noReservasi: widget.noReservasi,
                                                              imagePath: image.path,
                                                            ),
                                                          ),
                                                        );
                                                        context
                                                            .read<ReservasiBloc>()
                                                            .add(GetDetailRiwayatEvent(widget.noReservasi));
                                                        Navigator.pop(context, false);
                                                      }
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

                                                      if (photo != null) {
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => KonfirmasiBayarPage(
                                                              noReservasi: widget.noReservasi,
                                                              imagePath: photo.path,
                                                            ),
                                                          ),
                                                        );
                                                        context
                                                            .read<ReservasiBloc>()
                                                            .add(GetDetailRiwayatEvent(widget.noReservasi));
                                                        Navigator.pop(context, false);
                                                      }
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
                                        }
                                      : null,
                                  child: Text(
                                    data.noAntrian == 'null'
                                        ? 'Konfirmasi Pembayaran'
                                        : (data.statuskonfirm == 'Terdaftar'
                                            ? 'Telah Dikonfirmasi'
                                            : 'Menunggu konfirmasi'),
                                    style: const TextStyle(
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
