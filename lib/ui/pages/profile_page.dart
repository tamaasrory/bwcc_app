import 'dart:convert';
import 'dart:io';

import 'package:bwcc_app/bloc/auth_bloc.dart';
import 'package:bwcc_app/bloc/profile_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/user.dart';
import 'package:bwcc_app/ui/pages/change_password_page.dart';
import 'package:bwcc_app/ui/pages/daftar_keluarga_page.dart';
import 'package:bwcc_app/ui/pages/detail_profile_page.dart';
import 'package:bwcc_app/ui/pages/foto_editor_page.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'auth_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  User user = User();

  @override
  initState() {
    updateProfile();
    super.initState();
  }

  updateProfile() {
    BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SafeArea(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        // Using Wrap makes the bottom sheet height the height of the content.
                        // Otherwise, the height will be half the height of the screen.
                        return Wrap(
                          children: [
                            Container(
                              color: HexColor('#f5f5f5'),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              child: const Text(
                                'Unggah Foto Profile',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Pick an image
                                final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery,
                                );

                                if (image != null) {
                                  var tmp = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FotoEditorPage(
                                        imagePath: image.path,
                                      ),
                                    ),
                                  );
                                  if (tmp != null) {
                                    updateProfile();
                                  }
                                  Navigator.pop(context, false);
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                              ),
                              child: const ListTile(
                                leading: Icon(Icons.image),
                                title: Text('Ambil dari Gallery'),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Capture a photo
                                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

                                if (photo != null) {
                                  var tmp = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FotoEditorPage(
                                        imagePath: photo.path,
                                      ),
                                    ),
                                  );
                                  if (tmp != null) {
                                    updateProfile();
                                  }
                                  Navigator.pop(context, false);
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                              ),
                              child: const ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('Foto dari Kamera'),
                              ),
                            ),
                            const SizedBox(height: 70),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: HexColor('#eeeeee')),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: BlocListener<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        if (state is MyProfileState) {
                          user = state.data;
                          setState(() {});
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: user.avatar != null && user.avatar != 'null'
                            ? Image.network(
                                key: ObjectKey(user.avatar),
                                Urls.getStorage(user.avatar.toString()),
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.account_circle,
                                size: 60,
                                color: Colors.blueGrey,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                key: ObjectKey(user.username),
                user.username ?? '...',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0.0, 2.0),
                        blurRadius: 5,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          title: Text(
                            key: ObjectKey(user.noHandphone),
                            user.noHandphone ?? '...',
                            style: TextStyle(color: HexColor('#757575')),
                          ),
                          leading: const Icon(Icons.phone),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text(
                            key: ObjectKey(user.email),
                            user.email ?? '...',
                            style: TextStyle(color: HexColor('#757575')),
                          ),
                          leading: const Icon(Icons.mail),
                          onTap: () {},
                        ),
                      ],
                    ).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0.0, 2.0),
                        blurRadius: 5,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          title: const Text('Profile'),
                          leading: const Icon(Icons.manage_accounts_rounded),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailProfilePage(data: user),
                              ),
                            );
                            updateProfile();
                          },
                        ),
                        ListTile(
                          title: const Text('Daftar Keluarga'),
                          leading: const Icon(Icons.bookmark),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DaftarKeluargaPage(),
                              ),
                            );
                            updateProfile();
                          },
                        ),
                        ListTile(
                          title: const Text('Ganti Password'),
                          leading: const Icon(Icons.lock),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChangePasswordPage(),
                              ),
                            );
                          },
                        ),
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthAttampState) {
                              if (!state.isLogged) {
                                Navigator.of(context, rootNavigator: true).pushReplacement(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => const AuthPage(),
                                  ),
                                );
                              }
                            }
                          },
                          child: ListTile(
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            leading: Icon(
                              Icons.logout_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onTap: () {
                              dialogConfirm(
                                context,
                                title: 'Logout',
                                messages: 'Apakah Anda ingin logout sekarang juga ?',
                                negativeText: 'TIDAK',
                                positiveText: 'YA',
                                negativeAction: () {
                                  Navigator.of(context, rootNavigator: true).pop(false);
                                },
                                positiveAction: () {
                                  BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                                },
                                dismissable: true,
                              );
                            },
                          ),
                        ),
                      ],
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
