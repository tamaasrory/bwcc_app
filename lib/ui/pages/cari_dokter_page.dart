import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/pages/profile_dokter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CariDokterPage extends StatefulWidget {
  const CariDokterPage({Key? key}) : super(key: key);

  @override
  State<CariDokterPage> createState() => _CariDokterPageState();
}

class _CariDokterPageState extends State<CariDokterPage> {
  bool loadImgProfile = false;
  bool loading = false;
  bool ditemukan = false;
  String selectedPoli = 'SEMUA POLI';
  final _pilihanPoli = [
    'SEMUA POLI',
    'ANAK',
    'OBGYN',
    'ZYGOTE',
    'GIGI',
    'LAKTASI',
    'GIZI',
    'KULIT & KELAMIN',
  ];
  String selectedHari = 'SEMUA HARI';
  final _pilihanHari = [
    'SEMUA HARI',
    'SENIN',
    'SELASA',
    'RABU',
    'KAMIS',
    'JUMAT',
    'SABTU',
    'MINGGU',
  ];
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

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      'DOKTER KAMI',
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
              child: ditemukan
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'DOKTER POLI ',
                                ),
                                TextSpan(
                                  text: selectedPoli,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                const TextSpan(
                                  text: ';  HARI ',
                                ),
                                TextSpan(
                                  text: selectedHari,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(height: 5),
                        ListView(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          children: [
                            {
                              'photo': null,
                              'icon': AppAssets.baby,
                              'spesialis': '- Spesialis Anak\n- Telemedicine',
                              'nama': 'dr. Angelina, SpA',
                              'onPressed': () {
                                logApp('message run...');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileDokterPage(),
                                  ),
                                );
                              }
                            },
                            {
                              'photo': null,
                              'icon': AppAssets.baby,
                              'spesialis': '- Spesialis Anak\n- Telemedicine',
                              'nama': 'dr. Dwi Kartika, SpA',
                              'onPressed': () {
                                logApp('message run...');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileDokterPage(),
                                  ),
                                );
                              }
                            },
                            {
                              'photo': null,
                              'icon': AppAssets.baby,
                              'spesialis': '- Spesialis Anak\n- Telemedicine',
                              'nama': 'dr. Handoko Lowis, SpA',
                              'onPressed': () {
                                logApp('message run...');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileDokterPage(),
                                  ),
                                );
                              }
                            },
                            {
                              'photo': null,
                              'icon': AppAssets.baby,
                              'spesialis': '- Spesialis Anak\n- Telemedicine',
                              'nama': 'dr. Herwasto Jatmiko, SpA',
                              'onPressed': () {
                                logApp('message run...');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileDokterPage(),
                                  ),
                                );
                              }
                            },
                            {
                              'photo': null,
                              'icon': AppAssets.baby,
                              'spesialis': '- Spesialis Anak\n- Telemedicine',
                              'nama': 'dr. Liza Meilany, SpA',
                              'onPressed': () {
                                logApp('message run...');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileDokterPage(),
                                  ),
                                );
                              }
                            },
                          ].map((v) {
                            return GestureDetector(
                              onTap: v['onPressed'] as Function(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Flexible(
                                              flex: 1,
                                              child: v['photo'] != null
                                                  ? Image.network(v['photo'] as String)
                                                  : const Icon(
                                                      Icons.account_circle,
                                                      size: 45,
                                                      color: Colors.grey,
                                                    )),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  v['nama'] as String,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  v['spesialis'] as String,
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.secondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Image.asset(
                                              v['icon'] as String,
                                              width: 48,
                                              height: 48,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Pilihan ',
                                ),
                                TextSpan(
                                  text: 'Poli',
                                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                ),
                              ],
                            ),
                          ),
                          DropdownButton(
                            isExpanded: true,
                            // Initial Value
                            value: selectedPoli,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: _pilihanPoli.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items.contains('POLI') ? items : 'POLI ' + items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPoli = newValue.toString();
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Pilihan ',
                                ),
                                TextSpan(
                                  text: 'Hari',
                                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                ),
                              ],
                            ),
                          ),
                          DropdownButton(
                            isExpanded: true,
                            // Initial Value
                            value: selectedHari,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: _pilihanHari.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedHari = newValue.toString();
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: loading
                                  ? () => {}
                                  : () {
                                      loading = true;
                                      setState(() {});
                                      Future.delayed(const Duration(seconds: 2), () {
                                        loading = false;
                                        ditemukan = true;
                                        setState(() {});
                                      });
                                    },
                              child: loading
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text('Sedang Mencari', style: TextStyle(fontSize: 20))
                                      ],
                                    )
                                  : const Text('Cari', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Riwayat Pencarian',
                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                'KOSONG',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
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
