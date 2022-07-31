import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/artikel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class DetailArtikelPage extends StatefulWidget {
  final String slug;
  const DetailArtikelPage({Key? key, required this.slug}) : super(key: key);

  @override
  State<DetailArtikelPage> createState() => _DetailArtikelPageState();
}

class _DetailArtikelPageState extends State<DetailArtikelPage> {
  bool loadImgProfile = false;

  @override
  initState() {
    logApp('SLUG => ' + widget.slug.toString());
    BlocProvider.of<BerandaBloc>(context).add(GetDetailArtikelEvent(widget.slug));
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
                      'ARTIKEL',
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
                // padding: const EdgeInsets.symmetric(horizontal: 25),
                color: Theme.of(context).colorScheme.background,
                child: BlocBuilder<BerandaBloc, BerandaState>(
                  builder: (context, state) {
                    // var mQuery = MediaQuery.of(context).size;
                    // var acratio = mQuery.aspectRatio;
                    Artikel? data = state is ResultDetailArtikelState ? state.data : null;
                    return data != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                // borderRadius: BorderRadius.circular(8.0),
                                child: data.image != null
                                    ? InteractiveViewer(
                                        minScale: 1,
                                        maxScale: 4,
                                        child: Image.network(
                                          Urls.getIcon(data.image!),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/images/banner-1.jpg',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 5, left: 15, right: 15),
                                child: Text(
                                  data.judul.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                                child: Row(
                                  children: [
                                    // Text(
                                    //   data.author!.username.toString(),
                                    //   style: const TextStyle(
                                    //     color: Colors.blueGrey,
                                    //     fontWeight: FontWeight.w500,
                                    //     fontSize: 15,
                                    //   ),
                                    // ),
                                    // const SizedBox(width: 8),
                                    const Icon(
                                      Icons.calendar_month,
                                      size: 16,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      AppDateTime(data.createdAt).format('dd MMM yyyy'),
                                      style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0, bottom: 10, left: 8, right: 8),
                                child: Html(
                                    data: data.deskripsi.toString(),
                                    onLinkTap: (String? url, RenderContext context,
                                        Map<String, String> attributes, dom.Element? element) {
                                      openUrl(url.toString());
                                    }),
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
