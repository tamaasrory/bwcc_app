// ignore_for_file: prefer_const_constructors
import 'package:bwcc_app/bloc/bottom_navbar_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/pages/beranda_page.dart';
import 'package:bwcc_app/ui/pages/jadwal_dokter_page.dart';
import 'package:bwcc_app/ui/pages/detail_reservasi_page.dart';
import 'package:bwcc_app/ui/pages/riwayat_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageStorageBucket _pageBucket = PageStorageBucket();

  DateTime _backpressTime = DateTime.now();

  final List<Widget> _pages = [
    Navigator(
      key: ObjectKey('beranda'),
      onGenerateRoute: (settings) {
        logApp('settings.name => ' + settings.name.toString());

        // if (settings.name == 'page2') page = Page2();
        return MaterialPageRoute(
          builder: (_) => BerandaPage(
            key: PageStorageKey('Beranda'),
          ),
        );
      },
    ),
    JadwalDokterPage(
      key: PageStorageKey('Jadwal'),
    ),
    Navigator(
      key: ObjectKey('riwayat'),
      onGenerateRoute: (settings) {
        logApp('settings.name => ' + settings.name.toString());

        // if (settings.name == 'page2') page = Page2();
        return MaterialPageRoute(
          builder: (_) => RiwayatPage(
            key: PageStorageKey('Riwayat'),
          ),
        );
      },
    ),
    ProfilePage(
      key: PageStorageKey('Profile'),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<BottomNavbarBloc>().state;

    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(_backpressTime);
        final cantExit = timegap >= Duration(seconds: 2);
        _backpressTime = DateTime.now();
        if (cantExit) {
          // show snackbar
          showToast(context, 'Tekan back sekali lagi untuk keluar aplikasi');
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: PageStorage(
          bucket: _pageBucket,
          child: _pages[appState.index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary,
            size: 28,
            opacity: .8,
          ),
          unselectedIconTheme: IconThemeData(
            color: Theme.of(context).iconTheme.color,
            size: 24,
            opacity: .8,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_toggle_off),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
          currentIndex: appState.index,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          onTap: (index) => context.read<BottomNavbarBloc>().add(BottomNavbarEvent(index)),
        ),
      ),
    );
  }
}
