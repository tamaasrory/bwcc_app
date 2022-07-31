import 'package:bwcc_app/bloc/reservasi_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/pages/reservasi_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDokterPage extends StatefulWidget {
  final String dokterId;
  final String? poliId;

  const ProfileDokterPage({
    Key? key,
    required this.dokterId,
    required this.poliId,
  }) : super(key: key);

  @override
  State<ProfileDokterPage> createState() => _ProfileDokterPageState();
}

class _ProfileDokterPageState extends State<ProfileDokterPage> {
  bool loadImgProfile = false;
  List<String> polis = [];
  List<String?> polisIcon = [];

  @override
  initState() {
    BlocProvider.of<ReservasiBloc>(context).add(GetDetailDokterEvent(widget.dokterId));
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
                      'PROFIL DOKTER',
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
              child: BlocBuilder<ReservasiBloc, ReservasiState>(
                builder: (context, state) {
                  var poliId = 'null';
                  if (state is ResultGetDetailDokterState) {
                    List<Widget> groupPoli = [];
                    var headerGroup = [];
                    for (var gp in state.data.jadwal!) {
                      if (!headerGroup.contains(gp.poli)) {
                        if (poliId == 'null') {
                          poliId = gp.poliId.toString();
                        }
                        String tpname = gp.poli.toString();
                        groupPoli.add(Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Text(
                            (tpname.toLowerCase().contains('tele') ? '' : 'POLI ') + tpname,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ));
                        headerGroup.add(gp.poli);
                        polis.add('POLI ' + gp.poli.toString());
                        polisIcon.add(gp.icon);
                      }
                      groupPoli.add(
                        Column(
                          children: [
                            const Divider(thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    (gp.hari.toString()).toUpperCase(),
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    gp.jamAwal.toString().substring(0, 5) +
                                        ' - ' +
                                        gp.jamAkhir.toString().substring(0, 5),
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }

                    return Container(
                      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                      color: Theme.of(context).colorScheme.background,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: HexColor('#eeeeee')),
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
                                child: state.data.avatar != null
                                    ? Image.network(
                                        Urls.getStorage(state.data.avatar!),
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.account_circle,
                                        size: 45,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            state.data.nama.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ReservasiPage(
                                      dokterId: widget.dokterId.toString(),
                                      poliId: poliId.toString(),
                                    ),
                                  ),
                                );
                                BlocProvider.of<ReservasiBloc>(context)
                                    .add(GetDetailDokterEvent(widget.dokterId));
                              },
                              child: const Text(
                                'Buat Jadwal Reservasi',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'JADWAL PRAKTEK',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: groupPoli.toList(),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sedang Memuat data...'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
