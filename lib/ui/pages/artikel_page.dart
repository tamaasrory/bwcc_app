import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/artikel.dart';
import 'package:bwcc_app/ui/pages/detail_artikel_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({Key? key}) : super(key: key);

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {
  bool loadImgProfile = false;

  @override
  initState() {
    BlocProvider.of<BerandaBloc>(context).add(SetSlideArtikelEvent());
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
                      'DAFTAR ARTIKEL',
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
                    BlocBuilder<BerandaBloc, BerandaState>(
                      builder: (context, state) {
                        var mQuery = MediaQuery.of(context).size;
                        var acratio = mQuery.aspectRatio;

                        List<Artikel>? data = state is SlideArtikelState ? state.data : null;
                        return data != null
                            ? ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(10),
                                shrinkWrap: true,
                                children: data.map((v) {
                                  String deskripsi = '';
                                  String judul = '';
                                  if (v.deskripsi != null) {
                                    if (v.deskripsi!.length > ((mQuery.width * acratio) - 120)) {
                                      deskripsi = v.deskripsi!
                                              .substring(0, ((mQuery.width * acratio) - 120).toInt()) +
                                          '...';
                                    } else {
                                      deskripsi = v.deskripsi!;
                                    }
                                  }
                                  if (v.judul != null) {
                                    if (v.judul!.length > 45) {
                                      judul = v.judul!.substring(0, 45) + '...';
                                    } else {
                                      judul = v.judul!;
                                    }
                                  }
                                  return GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailArtikelPage(
                                            slug: v.slug.toString(),
                                          ),
                                        ),
                                      );
                                      BlocProvider.of<BerandaBloc>(context).add(SetSlideArtikelEvent());
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
                                              width: 150 * acratio,
                                              height: 150 * acratio,
                                              decoration: BoxDecoration(
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
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: v.image != null
                                                    ? Image.network(
                                                        Urls.getIcon(v.image!),
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
                                                  horizontal: 10,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Text(
                                                      judul,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      deskripsi,
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
