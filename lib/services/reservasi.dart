import 'dart:convert';

import 'package:bwcc_app/models/detail_dokter.dart';
import 'package:bwcc_app/models/dokter.dart';
import 'package:bwcc_app/models/form_reservasi.dart';
import 'package:bwcc_app/models/poli.dart';

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

  static Future<Responses<List>> postReservasi(FormReservasi formReservasi) async {
    try {
      var response = await ApiService.post("reservasi/store", formReservasi.toJson());

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
          results = List.from(results);
        }

        return Responses<List>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<List>(
          condition: false,
          message: 'Tidak dapat mengirim reservasi, silahkan coba lagi',
          results: null,
        );
      }
    } catch (e) {
      logApp('message ERROR => ' + e.toString());
      return Responses<List>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }
}
