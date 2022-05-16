import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/info.dart';
import 'package:bwcc_app/models/riwayat_reservasi.dart';
import 'package:bwcc_app/ui/pages/detail_info_page.dart';
import 'package:bwcc_app/ui/pages/detail_reservasi_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool loadImgProfile = false;

  @override
  initState() {
    BlocProvider.of<BerandaBloc>(context).add(SetSlideInfoEvent());
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
                      'DAFTAR PROMO',
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
                        List<Info>? data = state is SlideInfoState ? state.data : null;
                        return data != null
                            ? ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(10),
                                shrinkWrap: true,
                                children: data.map((v) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailInfoPage(
                                            id: v.id.toString(),
                                          ),
                                        ),
                                      );
                                      BlocProvider.of<BerandaBloc>(context).add(SetSlideInfoEvent());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(color: HexColor('#f5f5f5')),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                offset: const Offset(0, 5.0),
                                                blurRadius: 3,
                                                spreadRadius: 0,
                                              )
                                            ],
                                            //Border(top: BorderSide(color: HexColor('#cccccc'))),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 10,
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.calendar_month,
                                                      size: 16,
                                                      color: Colors.green,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      AppDateTime(v.updatedAt).format('dd MMM yyyy'),
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: HexColor('#888888'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: v.image != null
                                                    ? Image.network(
                                                        Urls.getIcon(v.image!),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        'assets/images/banner-1.jpg',
                                                        fit: BoxFit.cover,
                                                        width: 200 * acratio,
                                                      ),
                                              ),
                                            ],
                                          )),
                                    ),
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
