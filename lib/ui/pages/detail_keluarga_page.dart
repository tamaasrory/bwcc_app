import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/bloc/profile_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/artikel.dart';
import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailKeluargaPage extends StatefulWidget {
  final Pasien data;
  const DetailKeluargaPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailKeluargaPage> createState() => _DetailKeluargaPageState();
}

class _DetailKeluargaPageState extends State<DetailKeluargaPage> {
  @override
  initState() {
    logApp('SLUG => ' + widget.data.toString());
    // BlocProvider.of<BerandaBloc>(context).add(GetDetailArtikelEvent(widget.data));
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
            padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                      'DATA KELUARGA',
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
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
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
                        child: widget.data.avatar != null
                            ? Image.network(
                                Urls.getStorage(widget.data.avatar!),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/banner-1.jpg',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFieldWidget(
                        hint: 'Nama',
                        value: widget.data.nama,
                      ),
                    ),
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
