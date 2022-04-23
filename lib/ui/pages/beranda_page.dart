import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/user.dart';
import 'package:bwcc_app/ui/pages/cari_dokter_page.dart';
import 'package:bwcc_app/ui/widgets/banner_artikel.dart';
import 'package:bwcc_app/ui/widgets/banner_infopromo.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  bool loadImgProfile = false;

  // List<Map<String, dynamic>> _topMenus = ;

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
            'Hi, ${authState.data.email}',
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
                    logApp('run....');
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
                      GridView.count(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          {
                            'icon': 'icon_anak.png',
                            'label': 'Anak',
                            'onPressed': () {
                              logApp('run....');
                            },
                          },
                          {
                            'icon': 'icon_obgyn.png',
                            'label': 'Obgyn',
                            'onPressed': () {
                              logApp('run....');
                            },
                          },
                          {
                            'icon': 'icon_zygote.png',
                            'label': 'Zygote',
                            'onPressed': () {
                              logApp('run....');
                            },
                          },
                          {
                            'icon': 'icon_gigi.png',
                            'label': 'Gigi',
                            'onPressed': () {
                              logApp('run....');
                            },
                          },
                          {
                            'icon': 'icon_laktasi.png',
                            'label': 'Laktasi',
                            'onPressed': () {
                              logApp('run....');
                            },
                          },
                          {
                            'icon': 'icon_gizi.png',
                            'label': 'Gizi',
                            'onPressed': () {
                              logApp('run....');
                            },
                          },
                          {
                            'icon': 'icon_poli_kulit.png',
                            'label': 'Kulit',
                            'onPressed': () {
                              logApp('run....');
                            },
                          },
                        ].map((e) {
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
                                Image.asset(
                                  'assets/images/${e['icon']}',
                                  width: 80,
                                  height: 80,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 15,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Poli '),
                                      TextSpan(
                                        text: e['label'] as String,
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            onPressed: e['onPressed'] as Function(),
                          );
                        }).toList(),
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
                        logApp('run....');
                      },
                    },
                    {
                      'icon': 'ic_facebook.png',
                      'label': 'Reservasi',
                      'onPressed': () {
                        logApp('run....');
                      },
                    },
                    {
                      'icon': 'ic_youtube.png',
                      'label': 'Promo',
                      'onPressed': () {
                        logApp('run....');
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
}
