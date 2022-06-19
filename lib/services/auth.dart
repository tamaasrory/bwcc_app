import 'dart:convert';
import 'package:bwcc_app/models/form_register.dart';

import '../config/app.dart';
import '../models/responses.dart';
import '../models/user.dart';

class AuthService {
  // post login
  static Future<Responses<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      logApp(email + " " + password);
      var response = await ApiService.post("login", {
        "email": email,
        "password": password,
      });

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
          message: 'Tidak dapat melakukan login',
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

  // post
  static Future<Responses<User>> register({required FormRegister formRegister}) async {
    try {
      var response = await ApiService.post("register", formRegister.toJson());

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
          message: 'Tidak dapat melakukan pendaftaran',
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

  // post
  static Future<Responses<List>> forgotPassword({String? email}) async {
    try {
      // logApp("LOGOUT = " + username.toString() + " " + token.toString());
      var response = await ApiService.post("forgot-password", {
        "email": email.toString(),
      });

      if (response.statusCode == 200) {
        // logApp("LOGOUT = " + response.body.toString());

        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
        }

        return Responses<List>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<List>(
          condition: false,
          message: 'Sepertinya ada masalah, mohon coba lagi nanti.',
          results: null,
        );
      }
    } catch (e) {
      return Responses<List>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }

  static Future<Responses<List>> logout({
    String? email,
  }) async {
    try {
      // logApp("LOGOUT = " + username.toString() + " " + token.toString());
      var response = await ApiService.post("logout", {
        "email": email.toString(),
      });

      if (response.statusCode == 200) {
        // logApp("LOGOUT = " + response.body.toString());

        var jsonObject = jsonDecode(response.body);
        // ignore: prefer_typing_uninitialized_variables
        var results;
        if (jsonObject['results'] != null) {
          results = (jsonObject as Map<String, dynamic>)['results'];
        }

        return Responses<List>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<List>(
          condition: false,
          message: 'Sepertinya ada masalah',
          results: null,
        );
      }
    } catch (e) {
      return Responses<List>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }
}
