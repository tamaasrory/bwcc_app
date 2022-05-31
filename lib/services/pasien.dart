import 'dart:convert';

import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/models/user.dart';

import '../config/app.dart';
import '../models/responses.dart';

class PasienService {
  
  static Future<Responses<User>> getProfile() async {
    try {
      var response = await ApiService.get("user/profile");

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
          results = User.fromJson(results);
        }

        return Responses<User>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<User>(
          condition: false,
          message: 'User tidak ditemukan',
          results: null,
        );
      }
    } catch (e) {
      logApp('message ERROR => ' + e.toString());
      return Responses<User>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }

  static Future<Responses<List<Pasien>>> getDaftarKeluarga() async {
    try {
      var response = await ApiService.get(
        'pasien/daftar-keluarga',
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // logApp("jsonObject['results'] ==> " + jsonEncode(jsonObject['results']));

        return Responses<List<Pasien>>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: List<Pasien>.from(jsonObject['results'].map((value) {
            // logApp('PoliService ==> ' + jsonEncode(value));
            return Pasien.fromJson(value);
          })),
        );
      } else {
        return Responses<List<Pasien>>(
          condition: false,
          message: 'Tidak dapat memuat data, Sepertinya ada masalah',
          results: List<Pasien>.from([]),
        );
      }
    } catch (e) {
      logApp('PoliService error message => ' + e.toString());
      return Responses<List<Pasien>>(
        condition: false,
        message: 'Sepertinya ada masalah, Mohon periksa jaringan/koneksi anda',
        results: List<Pasien>.from([]),
      );
    }
  }

  static Future<Responses<Map<String, dynamic>>> postUpdateProfile({
    required String username,
    required String noHandphone,
  }) async {
    try {
      var response = await ApiService.post("pasien/update-profile", {
        'username': username,
        'no_handphone': noHandphone,
      });

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
          message: 'Tidak dapat mengirim perubahan, silahkan coba lagi',
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

  static Future<Responses<Map<String, dynamic>>> postUbahDataKeluarga(Pasien data) async {
    try {
      var response = await ApiService.post("pasien/update-keluarga", data.toJson());

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
          message: 'Tidak dapat mengirim perubahan, silahkan coba lagi',
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

  static Future<Responses<Map<String, dynamic>>> postTambahKeluarga(Pasien data) async {
    try {
      var response = await ApiService.post("pasien/tambah-keluarga", data.toJson());

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
          message: 'tidak dapat menyimpan data keluarga baru, silahkan coba lagi',
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

  static Future<Responses<Map<String, dynamic>>> postChangePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      var response = await ApiService.post("pasien/change-password", {
        'current-password': currentPassword,
        'new-password': newPassword,
      });

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
          message: 'tidak dapat menyimpan data keluarga baru, silahkan coba lagi',
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

  static Future<Responses<Map<String, dynamic>>> uploadFotoKeluarga(
      {String? id, required String file}) async {
    try {
      var response = await ApiService.postMultipart(
        'pasien/upload-foto-keluarga',
        fields: {'id': id.toString()},
        files: [
          {'name': 'file', 'path': file.toString()}
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
          message: 'Tidak dapat meng-upload foto, silahkan coba lagi',
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

  static Future<Responses<Map<String, dynamic>>> uploadFotoPribadi(String file) async {
    try {
      var response = await ApiService.postMultipart(
        'pasien/upload-foto-pribadi',
        files: [
          {'name': 'file', 'path': file}
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
          message: 'Tidak dapat meng-upload foto, silahkan coba lagi',
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
