import 'dart:convert';
import 'package:bwcc_app/models/contact.dart';

import '../config/app.dart';
import '../models/responses.dart';
import '../models/user.dart';

class ContactService {
  // post login
  static Future<Responses<Contact>> login({
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

        return Responses<Contact>(
          condition: jsonObject['condition'] as bool,
          message: jsonObject['message'],
          results: results,
        );
      } else {
        return Responses<Contact>(
          condition: false,
          message: 'Tidak dapat melakukan login',
          results: null,
        );
      }
    } catch (e) {
      logApp('message ERROR => ' + e.toString());
      return Responses<Contact>(
        condition: false,
        message: getMessage(e),
        results: null,
      );
    }
  }
}
