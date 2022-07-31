import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/config/date_time.dart';
import 'package:bwcc_app/models/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class DetailInfoPage extends StatefulWidget {
  final String id;
  const DetailInfoPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailInfoPage> createState() => _DetailInfoPageState();
}

class _DetailInfoPageState extends State<DetailInfoPage> {
  bool loadImgProfile = false;

  @override
  initState() {
    BlocProvider.of<BerandaBloc>(context).add(GetDetailInfoEvent(widget.id));
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
                      'DETAIL INFO',
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
            child: BlocBuilder<BerandaBloc, BerandaState>(
              builder: (context, state) {
                // var mQuery = MediaQuery.of(context).size;
                // var acratio = mQuery.aspectRatio;
                Info? data = state is ResultDetailInfoState ? state.data : null;
                return data != null
                    ? data.image != null
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
                          )
                    : const Center(
                        child: Text('Data tidak ditemukan'),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
