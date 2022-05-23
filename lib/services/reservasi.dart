import 'dart:convert';

import 'package:bwcc_app/models/detail_dokter.dart';
import 'package:bwcc_app/models/dokter.dart';
import 'package:bwcc_app/models/form_reservasi.dart';
import 'package:bwcc_app/models/konfirmasi_pembayaran.dart';
import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/models/riwayat_reservasi.dart';
import 'package:bwcc_app/models/select.dart';

import '../config/app.dart';
import '../models/responses.dart';

class ReservasiService {
  static Future<Responses<List<Dokter>>> index({
    String? poliId,
    String? hari,
  }) async {
    try {
      var response = await ApiService.get('reservasi', query: {
        'data': 'dokter',
        'poli_id': poliId ?? '-1',
        'hari': hari ?? '-1',
      });

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Dokter>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Dokter>.from(jsonObject['results'].map((value) {
            // logApp('DokterService ==> ' + jsonEncode(value));
            return Dokter.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Dokter>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Dokter>.from([]),
        );
      }
    } catch (e) {
      logApp('DokterService error message => ' + e.toString());
      return Responses<List<Dokter>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Dokter>.from([]),
      );
    }
  }

  static Future<Responses<List<Select>>> getAllPoli() async {
    try {
      var response = await ApiService.get('poli');

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Select>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Select>.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return Select.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Select>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Select>.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List<Select>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Select>.from([]),
      );
    }
  }

  static Future<Responses<List<Select>>> getPembayaran() async {
    try {
      var response = await ApiService.get('metode-pembayaran');

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Select>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Select>.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return Select.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Select>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Select>.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List<Select>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Select>.from([]),
      );
    }
  }

  static Future<Responses<DetailDokter>> getDetailDokter({required String id}) async {
    try {
      var response = await ApiService.get('detail-dokter', query: {'id': id});

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<DetailDokter>(
            condition: jsonObject['condition'] as bool,
            message: jsonObject['message'],
            results: DetailDokter.fromJson(jsonObject['results']));
      } else {
        return Responses<DetailDokter>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: DetailDokter(),
        );
      }
    } catch (e) {
      logApp('DetailDokterService error message => ' + e.toString());
      return Responses<DetailDokter>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: DetailDokter(),
      );
    }
  }

  static Future<Responses<List<Select>>> getDokterReservasi({
    required String poliId,
  }) async {
    try {
      var response = await ApiService.get(
        'reservasi',
        query: {
          'data': 'dokter',
          'mode': 'select',
          'poli_id': poliId,
        },
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Select>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Select>.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return Select.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Select>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Select>.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List<Select>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Select>.from([]),
      );
    }
  }

  static Future<Responses<List>> getHariReservasi({
    required String dokterId,
    required String poliId,
  }) async {
    try {
      var response = await ApiService.get(
        'reservasi',
        query: {
          'data': 'hari',
          'mode': 'select',
          'dokter': dokterId,
          'poli_id': poliId,
        },
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return value;
          })),
        );
      } else {
        return Responses<List>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List.from([]),
      );
    }
  }

  static Future<Responses<List<Select>>> getWaktuReservasi({
    required String dokterId,
    required String poliId,
    required String hari,
  }) async {
    try {
      var response = await ApiService.get(
        'reservasi',
        query: {
          'data': 'jam',
          'mode': 'select',
          'dokter': dokterId.toString(),
          'poli_id': poliId.toString(),
          'hari': hari.toString(),
        },
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Select>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Select>.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return Select.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Select>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Select>.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List<Select>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Select>.from([]),
      );
    }
  }

  static Future<Responses<Map<String, dynamic>>> postReservasi(FormReservasi formReservasi) async {
    try {
      var response = await ApiService.post("reservasi/store", formReservasi.toJson());

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
          // results = List.from(results);
        }

        return Responses<Map<String, dynamic>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<Map<String, dynamic>>(
          condition: false,
          message: 'Tidak dapat mengirim reservasi, silahkan coba lagi',
          results: null,
        );
      }
    } catch (e) {
      logApp('message ERROR => ' + e.toString());
      return Responses<Map<String, dynamic>>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }

  static Future<Responses<List<RiwayatReservasi>>> getRiwayat() async {
    try {
      var response = await ApiService.get('reservasi/riwayat');

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<RiwayatReservasi>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<RiwayatReservasi>.from(jsonObject['results'].map((value) {
            // logApp('RiwayatReservasiService ==> ' + jsonEncode(value));
            return RiwayatReservasi.fromJson(value);
          })),
        );
      } else {
        return Responses<List<RiwayatReservasi>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<RiwayatReservasi>.from([]),
        );
      }
    } catch (e) {
      logApp('RiwayatReservasiService error message => ' + e.toString());
      return Responses<List<RiwayatReservasi>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<RiwayatReservasi>.from([]),
      );
    }
  }

  static Future<Responses<RiwayatReservasi>> getDetailRiwayat({required String noReservasi}) async {
    try {
      var response = await ApiService.get("reservasi/detail", query: {'no_reservasi': noReservasi});

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
          results = RiwayatReservasi.fromJson(results);
        }

        return Responses<RiwayatReservasi>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<RiwayatReservasi>(
          condition: false,
          message: 'Tidak dapat melakukan login',
          results: null,
        );
      }
    } catch (e) {
      logApp('message ERROR => ' + e.toString());
      return Responses<RiwayatReservasi>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }

  static Future<Responses<Map<String, dynamic>>> postKonfirmasi(String noReservasi, String file) async {
    try {
      var response = await ApiService.postMultipart(
        'reservasi/konfirmasi',
        fields: {'no_reservasi': noReservasi},
        files: [
          {'name': 'image', 'path': file}
        ],
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
          // results = List.from(results);
        }

        return Responses<Map<String, dynamic>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<Map<String, dynamic>>(
          condition: false,
          message: 'Tidak dapat melakukan konfirmasi, silahkan coba lagi',
          results: null,
        );
      }
    } catch (e) {
      logApp('message ERROR => ' + e.toString());
      return Responses<Map<String, dynamic>>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }
}
