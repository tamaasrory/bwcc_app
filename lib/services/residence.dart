import 'dart:convert';

import 'package:bwcc_app/models/select.dart';

import '../config/app.dart';
import '../models/responses.dart';

class ResidenceService {
  static Future<Responses<List<Select>>> getProvinsi() async {
    try {
      var response = await ApiService.get('residence/provinces');

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

  static Future<Responses<List<Select>>> getKabupaten(String id) async {
    try {
      var response = await ApiService.get('residence/cities', query: {'id': id});

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

  static Future<Responses<List<Select>>> getDistricts(String id) async {
    try {
      var response = await ApiService.get('residence/districts', query: {'id': id});

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

  static Future<Responses<List<Select>>> getvVillages(String id) async {
    try {
      var response = await ApiService.get('residence/villages', query: {'id': id});

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
}
