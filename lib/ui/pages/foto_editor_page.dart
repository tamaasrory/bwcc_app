import 'dart:io';
import 'dart:typed_data';

import 'package:bwcc_app/bloc/profile_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FotoEditorPage extends StatefulWidget {
  final String? id;
  final String imagePath;
  const FotoEditorPage({Key? key, required this.imagePath, this.id}) : super(key: key);

  @override
  State<FotoEditorPage> createState() => _FotoEditorPageState();
}

class _FotoEditorPageState extends State<FotoEditorPage> {
  bool loading = false;
  bool _cropping = false;
  String? imagetmp;

  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();

  Future<void> cropImage() async {
    if (_cropping) {
      return;
    }
    _cropping = true;
    try {
      final Uint8List? fileData = await cropImageDataWithNativeLibrary(state: editorKey.currentState!);
      final String? fileFath = await ImageSaver.save('extended_image_cropped_image.jpg', fileData!);
      imagetmp = fileFath;
      // logApp('save image : ' + fileFath.toString());
      setState(() {});
    } finally {
      _cropping = false;
    }
  }

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
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              color: Theme.of(context).colorScheme.primary,
              child: SafeArea(
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                        ),
                        onPressed: () {
                          Navigator.pop(context, null);
                        },
                        child: Image.asset(
                          AppAssets.backWhite,
                          width: 32,
                          height: 32,
                        ),
                      ),
                      const Text(
                        'Upload Foto',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Image.asset(
                        AppAssets.icLogo,
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 10,
            ),
            child: imagetmp != null
                ? SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.file(
                      File(imagetmp!),
                      fit: BoxFit.contain,
                    ),
                  )
                : ExtendedImage.file(
                    File(widget.imagePath),
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    compressionRatio: 0.1,
                    maxBytes: 100,
                    enableLoadState: true,
                    extendedImageEditorKey: editorKey,
                    cacheRawData: true,
                    width: 300,
                    height: 300,
                    initEditorConfigHandler: (ExtendedImageState? state) {
                      return EditorConfig(
                          maxScale: 1,
                          initCropRectType: InitCropRectType.imageRect,
                          cropAspectRatio: 1,
                          initialCropAspectRatio: 4.0 / 4.0,
                          editActionDetailsIsChanged: (EditActionDetails? details) {
                            //print(details?.totalScale);
                          });
                    },
                  ),
          ),
          SizedBox(
            child: imagetmp != null
                ? Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          imagetmp = null;
                          setState(() {});
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [Icon(Icons.undo_rounded), SizedBox(width: 5), Text('ULANGI EDIT')],
                        ),
                      ),
                      const SizedBox(width: 5),
                      BlocListener<ProfileBloc, ProfileState>(
                        listener: (context, state) {
                          loading = state is ProgessState ? state.loading : false;
                          setState(() {});
                          if (state is ProgessState) {
                            if (['ganti_foto_kk', 'ganti_foto_user'].contains(state.key)) {
                              if (state.extra != null) {
                                Future.delayed(const Duration(milliseconds: 1200), () {
                                  Navigator.of(context, rootNavigator: true).pop(false);
                                  dialogInfo(context, messages: state.extra.message, actions: [
                                    TextButton(
                                      onPressed: state.extra.condition
                                          ? () {
                                              Navigator.of(context, rootNavigator: true).pop(false);
                                              Navigator.pop(context, state.extra.results['avatar']);
                                            }
                                          : () {
                                              Navigator.of(context, rootNavigator: true).pop(false);
                                              if (widget.id != null) {
                                                context.read<ProfileBloc>().add(
                                                    UploadFotoKeluargaEvent(id: widget.id!, path: imagetmp!));
                                              } else {
                                                context
                                                    .read<ProfileBloc>()
                                                    .add(UploadFotoPribadiEvent(imagetmp!));
                                              }
                                            },
                                      child: Text(state.extra.condition ? 'Tutup' : 'Kirim Ulang'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context, rootNavigator: true).pop(false);
                                        Navigator.pop(context, state.extra.results['avatar']);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ]);
                                });
                              } else {
                                dialogInfo(
                                  context,
                                  title: 'Mohon tunggu sebentar',
                                  messages: 'Sedang meng-unggah foto baru',
                                  dismissable: false,
                                );
                              }
                            }
                          }
                        },
                        child: ElevatedButton(
                          onPressed: loading
                              ? () {}
                              : () {
                                  if (widget.id != null) {
                                    context
                                        .read<ProfileBloc>()
                                        .add(UploadFotoKeluargaEvent(id: widget.id!, path: imagetmp!));
                                  } else {
                                    context.read<ProfileBloc>().add(UploadFotoPribadiEvent(imagetmp!));
                                  }
                                },
                          child: loading
                              ? Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: const [
                                    Icon(Icons.upload),
                                    SizedBox(width: 5),
                                    Text('UNGGAH FOTO')
                                  ],
                                ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: () {
                        cropImage();
                      },
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [Icon(Icons.check_rounded), SizedBox(width: 5), Text('SIMPAN')],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
