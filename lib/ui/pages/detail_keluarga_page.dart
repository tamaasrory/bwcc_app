import 'dart:convert';
import 'dart:io';

import 'package:bwcc_app/bloc/profile_bloc.dart';
import 'package:bwcc_app/bloc/residence_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/models/select.dart';
import 'package:bwcc_app/ui/pages/foto_editor_page.dart';
import 'package:bwcc_app/ui/widgets/color_full_label.dart';
import 'package:bwcc_app/ui/widgets/dialog.dart';
import 'package:bwcc_app/ui/widgets/dropdown.dart';
import 'package:bwcc_app/ui/widgets/text_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DetailKeluargaPage extends StatefulWidget {
  final Pasien data;
  const DetailKeluargaPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailKeluargaPage> createState() => _DetailKeluargaPageState();
}

class _DetailKeluargaPageState extends State<DetailKeluargaPage> {
  DateTime? initialTglLahir;
  String? currentAvatar;

  List<Select> _pilihanProvinsi = [
    Select(text: 'PILIH PROVINSI', value: 'null'),
  ];

  List<Select> _pilihanKab = [
    Select(text: 'PILIH KABUPATEN', value: 'null'),
  ];

  List<Select> _pilihanKec = [
    Select(text: 'PILIH KECAMATAN', value: 'null'),
  ];

  List<Select> _pilihanDesa = [
    Select(text: 'PILIH DESA', value: 'null'),
  ];

  final List<Select> _pilihanGolDarah = [
    Select(text: 'PILIH', value: 'null'),
    Select(text: 'A', value: 'A'),
    Select(text: 'B', value: 'B'),
    Select(text: 'AB', value: 'AB'),
    Select(text: '0', value: '0'),
  ];
  bool loading = false;
  final ImagePicker _picker = ImagePicker();

  _isValid() {
    return true;
  }

  @override
  initState() {
    BlocProvider.of<ResidenceBloc>(context).add(GetProvincesEvent());
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
                      'DATA KELUARGA',
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: HexColor('#eeeeee')),
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
                          child: currentAvatar == null
                              ? (widget.data.avatar != null
                                  ? Image.network(
                                      Urls.getStorage(widget.data.avatar!),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/banner-1.jpg',
                                      fit: BoxFit.cover,
                                    ))
                              : Image.network(
                                  Urls.getStorage(currentAvatar),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            primary: Theme.of(context).colorScheme.secondary,
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
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
                                          currentAvatar = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FotoEditorPage(
                                                id: widget.data.id.toString(),
                                                imagePath: image.path,
                                              ),
                                            ),
                                          );
                                          setState(() {});
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
                                        final XFile? photo =
                                            await _picker.pickImage(source: ImageSource.camera);

                                        if (photo != null) {
                                          currentAvatar = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FotoEditorPage(
                                                id: widget.data.id.toString(),
                                                imagePath: photo.path,
                                              ),
                                            ),
                                          );
                                          setState(() {});
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
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [Icon(Icons.upload), SizedBox(width: 5), Text('UNGGAH FOTO')],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                        right: 10,
                        bottom: 10,
                        left: 10,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(0.0, 2.0),
                              blurRadius: 5,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFieldWidget(
                              customelabel: richLable(context, '', 'Nama'),
                              hint: 'Nama',
                              value: widget.data.nama,
                              onChanged: (v) {
                                widget.data.nama = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            TextFieldWidget(
                              customelabel: richLable(context, 'Nomor ', 'KTP/KIA'),
                              hint: 'KTP/KIA (jika pasien anak)',
                              value: widget.data.nik,
                              onChanged: (v) {
                                widget.data.nik = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            TextFieldWidget(
                              customelabel: richLable(context, 'Nomor ', 'Rekam Medis'),
                              hint: 'Nomor Rekam Medis',
                              value: widget.data.nrm,
                              onChanged: (v) {
                                widget.data.nrm = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            TextFieldWidget(
                              customelabel: richLable(context, 'Nama ', 'Penanggung Jawab'),
                              hint: 'Nama Penanggung Jawab',
                              value: widget.data.namaPenanggungjawab,
                              onChanged: (v) {
                                widget.data.namaPenanggungjawab = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            richLable(context, '', 'Jenis Kelamin'),
                            const SizedBox(height: 10),
                            Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Radio(
                                  value: 'Laki-laki',
                                  groupValue: widget.data.jenisKelamin,
                                  onChanged: (String? value) {
                                    setState(() {
                                      widget.data.jenisKelamin = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Laki-Laki',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 15),
                                Radio(
                                  value: 'Wanita',
                                  groupValue: widget.data.jenisKelamin,
                                  onChanged: (String? value) {
                                    setState(() {
                                      widget.data.jenisKelamin = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Wanita',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            SelectWidget(
                              label: const ['Pilih ', 'Golongan Darah'],
                              value: widget.data.golonganDarah,
                              items: _pilihanGolDarah.map((e) => e.toJson()).toList(),
                              onChanged: (newValue) {
                                widget.data.golonganDarah = newValue.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            TextFieldWidget(
                              customelabel: richLable(context, '', 'Umur'),
                              hint: 'Umur',
                              value: widget.data.umur,
                              onChanged: (v) {
                                widget.data.umur = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            TextFieldWidget(
                              customelabel: richLable(context, '', 'No. Telepon'),
                              hint: 'No. Telepon',
                              value: widget.data.phone,
                              onChanged: (v) {
                                widget.data.phone = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 10),
                            richLable(context, '', 'Tanggal Lahir'),
                            DateTimePicker(
                              key: ObjectKey(initialTglLahir),
                              type: DateTimePickerType.date,
                              locale: const Locale('id'),
                              dateMask: 'dd/MMM/yyyy',
                              initialValue: widget.data.tglLahir,
                              initialDate: initialTglLahir,
                              dateHintText: 'Tanggal Lahir',
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              onChanged: (val) {
                                setState(() {
                                  widget.data.tglLahir = val;
                                });
                              },
                              validator: (val) {
                                return null;
                              },
                            ),
                            const SizedBox(height: 25),
                            TextFieldWidget(
                              customelabel: richLable(context, '', 'Tempat Lahir'),
                              hint: 'Tempat Lahir',
                              value: widget.data.tempatLahir,
                              onChanged: (v) {
                                widget.data.tempatLahir = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            TextFieldWidget(
                              customelabel: richLable(context, '', 'Alamat'),
                              hint: 'Alamat',
                              value: widget.data.alamat,
                              onChanged: (v) {
                                widget.data.alamat = v.toString();
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 25),
                            BlocListener<ResidenceBloc, ResidenceState>(
                              listener: (context, state) {
                                if (state is ResultProvincesState) {
                                  if (state.data.isNotEmpty) {
                                    _pilihanProvinsi = [
                                      Select(text: 'PILIH PROVINSI', value: 'null'),
                                    ];
                                    _pilihanProvinsi.addAll(state.data);
                                    setState(() {});
                                    if (widget.data.provinsi != 'null') {
                                      var tmp = getValue(_pilihanProvinsi, widget.data.provinsi) as Select;
                                      context.read<ResidenceBloc>().add(GetCitiesEvent(tmp.id.toString()));
                                    }
                                  }
                                }
                              },
                              child: SelectWidget(
                                label: const ['Pilih ', 'Provinsi'],
                                value: widget.data.provinsi,
                                items: _pilihanProvinsi.map((e) => e.toJson()).toList(),
                                onChanged: (newValue) {
                                  widget.data.provinsi = newValue.toString();
                                  var tmp = getValue(_pilihanProvinsi, newValue.toString()) as Select;
                                  widget.data.kabKota = 'null';
                                  widget.data.kecamatan = 'null';
                                  widget.data.desa = 'null';
                                  _pilihanKab = [
                                    Select(text: 'PILIH KABUPATEN', value: 'null'),
                                  ];
                                  _pilihanKec = [
                                    Select(text: 'PILIH KECAMATAN', value: 'null'),
                                  ];
                                  _pilihanDesa = [
                                    Select(text: 'PILIH DESA', value: 'null'),
                                  ];
                                  setState(() {});
                                  context.read<ResidenceBloc>().add(GetCitiesEvent(tmp.id.toString()));
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            BlocListener<ResidenceBloc, ResidenceState>(
                              listener: (context, state) {
                                if (state is ResultCitiesState) {
                                  if (state.data.isNotEmpty) {
                                    _pilihanKab = [
                                      Select(text: 'PILIH KABUPATEN', value: 'null'),
                                    ];
                                    _pilihanKab.addAll(state.data);
                                    setState(() {});
                                    if (widget.data.kabKota != 'null') {
                                      var tmp = getValue(_pilihanKab, widget.data.kabKota) as Select;
                                      context.read<ResidenceBloc>().add(GetDistrictsEvent(tmp.id.toString()));
                                    }
                                  }
                                }
                              },
                              child: SelectWidget(
                                label: const ['Pilih ', 'Kabupaten'],
                                value: widget.data.kabKota,
                                items: _pilihanKab.map((e) => e.toJson()).toList(),
                                onChanged: (newValue) {
                                  widget.data.kabKota = newValue.toString();
                                  widget.data.kecamatan = 'null';
                                  widget.data.desa = 'null';
                                  _pilihanKec = [
                                    Select(text: 'PILIH KECAMATAN', value: 'null'),
                                  ];
                                  _pilihanDesa = [
                                    Select(text: 'PILIH DESA', value: 'null'),
                                  ];
                                  setState(() {});
                                  if (widget.data.kabKota != 'null') {
                                    var tmp = getValue(_pilihanKab, widget.data.kabKota) as Select;
                                    context.read<ResidenceBloc>().add(GetDistrictsEvent(tmp.id.toString()));
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            BlocListener<ResidenceBloc, ResidenceState>(
                              listener: (context, state) {
                                if (state is ResultDistrictsState) {
                                  if (state.data.isNotEmpty) {
                                    _pilihanKec = [
                                      Select(text: 'PILIH KECAMATAN', value: 'null'),
                                    ];
                                    _pilihanKec.addAll(state.data);
                                    setState(() {});
                                    if (widget.data.kecamatan != 'null') {
                                      var tmp = getValue(_pilihanKec, widget.data.kecamatan) as Select;
                                      context.read<ResidenceBloc>().add(GetVillagesEvent(tmp.id.toString()));
                                    }
                                  }
                                }
                              },
                              child: SelectWidget(
                                label: const ['Pilih ', 'Kecamatan'],
                                value: widget.data.kecamatan,
                                items: _pilihanKec.map((e) => e.toJson()).toList(),
                                onChanged: (newValue) {
                                  widget.data.kecamatan = newValue.toString();
                                  widget.data.desa = 'null';
                                  _pilihanDesa = [
                                    Select(text: 'PILIH DESA', value: 'null'),
                                  ];
                                  setState(() {});
                                  if (widget.data.kecamatan != 'null') {
                                    var tmp = getValue(_pilihanKec, widget.data.kecamatan) as Select;
                                    context.read<ResidenceBloc>().add(GetVillagesEvent(tmp.id.toString()));
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            BlocListener<ResidenceBloc, ResidenceState>(
                              listener: (context, state) {
                                if (state is ResultVillagesState) {
                                  if (state.data.isNotEmpty) {
                                    _pilihanDesa = [
                                      Select(text: 'PILIH DESA', value: 'null'),
                                    ];
                                    _pilihanDesa.addAll(state.data);
                                    setState(() {});
                                  }
                                }
                              },
                              child: SelectWidget(
                                label: const ['Pilih ', 'Desa'],
                                value: widget.data.desa,
                                items: _pilihanDesa.map((e) => e.toJson()).toList(),
                                onChanged: (newValue) {
                                  widget.data.desa = newValue.toString();
                                  setState(() {});
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            TextFieldWidget(
                              customelabel: richLable(context, '', 'Kode Pos'),
                              hint: 'Kode Pos',
                              value: widget.data.kodepos,
                              onChanged: (v) {
                                widget.data.kodepos = v.toString();
                                setState(() {});
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                              child: BlocListener<ProfileBloc, ProfileState>(
                                listener: (context, state) {
                                  if (state is ProgessState) {
                                    if (state.key == 'detail_keluarga_page') {
                                      loading = state.loading;
                                      if (!state.loading) {
                                        Future.delayed(const Duration(milliseconds: 1250), () {
                                          setState(() {});
                                          if (state.extra != null) {
                                            dialogInfo(
                                              context,
                                              title: 'Berhasil Menyimpan Perubahan',
                                              messages: 'Data anda berhasil diperbarui, terimakasih',
                                            );
                                          } else {
                                            dialogInfo(
                                              context,
                                              title: 'Gagal Menyimpan Perubahan',
                                              messages:
                                                  'Serpertinya ada masalah, silahkan coba ulang beberapa saat lagi',
                                            );
                                          }
                                        });
                                      } else {
                                        setState(() {});
                                      }
                                    }
                                  }
                                },
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                    primary: Theme.of(context).colorScheme.secondary,
                                    textStyle: const TextStyle(fontSize: 18),
                                  ),
                                  onPressed: _isValid()
                                      ? (loading
                                          ? () {}
                                          : () {
                                              logApp(
                                                'HASIL FORM DATA => ' + jsonEncode(widget.data.toJson()),
                                              );

                                              BlocProvider.of<ProfileBloc>(context)
                                                  .add(PostUbahProfileKeluargaEvent(widget.data));
                                            })
                                      : null,
                                  child: loading
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(color: Colors.white),
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              'Sedang Mengirim',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        )
                                      : const Text(
                                          'Simpan Perubahan',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
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
