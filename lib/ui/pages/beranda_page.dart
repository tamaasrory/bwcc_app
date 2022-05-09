import 'dart:convert';

import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/layanan_kami.dart';
import 'package:bwcc_app/models/user.dart';
import 'package:bwcc_app/ui/pages/reservasi_page.dart';
import 'package:bwcc_app/ui/widgets/banner_artikel.dart';
import 'package:bwcc_app/ui/widgets/banner_infopromo.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cari_dokter_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  bool loadImgProfile = false;
  List<LayananKami> _gridMenus = [];

  // List<Map<String, dynamic>> _topMenus = ;

  @override
  initState() {
    Future.delayed(const Duration(milliseconds: 1200), () {
      logApp('sending request slide layanan');
      context.read<BerandaBloc>().add(SetSlideLayananEvent());
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      logApp('sending request slide info');
      context.read<BerandaBloc>().add(SetSlideInfoEvent());
    });

    Future.delayed(const Duration(milliseconds: 1700), () {
      logApp('sending request slide artikel');
      context.read<BerandaBloc>().add(SetSlideArtikelEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark,
    ));

    var _state = context.watch<AuthBloc>().state;
    AuthAttampState authState = (_state is AuthAttampState) ? _state : AuthAttampState(data: User());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 15),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 34,
                      width: 34,
                      child: Image.asset(
                        AppAssets.logoNew,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 4,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'INFO : ',
                          ),
                          TextSpan(
                            text: 'dr. Riyana Mulai Tanggal 5 Cuti',
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider(thickness: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Text(
            'Hi, ${authState.data.username}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 7, right: 7, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  offset: const Offset(0.0, 2.0),
                  blurRadius: 3,
                  spreadRadius: 0,
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.count(
              padding: const EdgeInsets.symmetric(vertical: 10),
              shrinkWrap: true,
              crossAxisCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                {
                  'icon': Icons.person_search_rounded,
                  'label': 'Cari Dokter',
                  'onPressed': () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CariDokterPage()));
                  },
                },
                {
                  'icon': Icons.content_paste,
                  'label': 'Reservasi',
                  'onPressed': () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ReservasiPage()));
                  },
                },
                {
                  'icon': Icons.discount,
                  'label': 'Promo',
                  'onPressed': () {
                    logApp('run....');
                  },
                },
                {
                  'icon': Icons.newspaper,
                  'label': 'Artikel',
                  'onPressed': () {
                    logApp('run....');
                  },
                },
              ].map((e) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    elevation: 0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(e['icon'] as IconData, size: 32),
                      const SizedBox(height: 5),
                      Text(
                        e['label'] as String,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  onPressed: e['onPressed'] as Function(),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(0.0, 2.0),
                        blurRadius: 3,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            children: [
                              const TextSpan(text: 'Layanan '),
                              TextSpan(
                                text: 'BWCC',
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                      BlocListener<BerandaBloc, BerandaState>(
                        listener: (context, state) {
                          if (state is SlideLayananState) {
                            logApp('SLIDES => ' + jsonEncode(state.slides));
                            _gridMenus = state.slides;
                            setState(() {});
                          }
                        },
                        child: GridView.count(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _gridMenus.map((e) {
                            var labels = e.judul?.split(' ');
                            List<TextSpan> wLabel = [];

                            if ((labels?.length ?? 0) > 1) {
                              wLabel.addAll([
                                const TextSpan(text: 'Poli '),
                                TextSpan(
                                  text: e.judul?.replaceFirst('Poli ', ''),
                                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                ),
                              ]);
                            } else {
                              wLabel.add(TextSpan(
                                text: e.judul,
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                              ));
                            }

                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                elevation: 0,
                                primary: Theme.of(context).colorScheme.background,
                                onPrimary: Theme.of(context).colorScheme.primary,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Image.asset(
                                  //   'assets/images/${e['icon']}',
                                  //   width: 80,
                                  //   height: 80,
                                  // ),
                                  Image.network(
                                    Urls.getIcon(e.icon),
                                    width: 80,
                                    height: 80,
                                    errorBuilder: (a, b, c) {
                                      return Image.asset(
                                        'assets/images/logo_white_background.png',
                                        width: 80,
                                        height: 80,
                                      );
                                    },
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).colorScheme.primary,
                                        fontSize: 15,
                                      ),
                                      children: wLabel,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                dialogContent(
                                  context,
                                  title: e.judul ?? 'Poli',
                                  contentPadding: EdgeInsets.zero,
                                  contents: SizedBox(
                                    height: (MediaQuery.of(context).size.height / 2) - 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 180,
                                            width: 180,
                                            child: Image.network(Urls.getIcon(e.featureImage)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Text(e.deskripsi!),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      children: [
                        const TextSpan(text: 'Info '),
                        TextSpan(
                          text: 'Promo',
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                ),
                const BannerInfoPromo(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      children: [
                        const TextSpan(text: 'Artikel '),
                        TextSpan(
                          text: 'Tips',
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                ),
                const BannerArtikel(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      children: [
                        const TextSpan(text: 'Social Media '),
                        TextSpan(
                          text: 'BWCC',
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    {
                      'icon': 'ic_ig.png',
                      'label': 'Cari Dokter',
                      'onPressed': () {
                        _launchUrl('https://www.instagram.com/bwcc_bintaro/');
                      },
                    },
                    {
                      'icon': 'ic_facebook.png',
                      'label': 'Reservasi',
                      'onPressed': () {
                        _launchUrl('https://facebook.com/bwccbintaro/');
                      },
                    },
                    {
                      'icon': 'ic_youtube.png',
                      'label': 'Promo',
                      'onPressed': () {
                        _launchUrl('https://www.youtube.com/channel/UCUTDtLLjdvCF8gHBw9zvjuw');
                      },
                    },
                  ].map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(2),
                          minimumSize: const Size(0, 0),
                          elevation: 0,
                          primary: Colors.white,
                          onPrimary: Colors.teal,
                        ),
                        child: Image.asset(
                          'assets/images/' + (e['icon'] as String),
                          width: 50,
                        ),
                        onPressed: e['onPressed'] as Function(),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}
