import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:ffi';
import 'dart:math';

import 'dart:io' as io;
import 'package:flutter/material.dart'
    show
        BorderRadius,
        Color,
        Colors,
        EdgeInsets,
        MaterialPageRoute,
        MediaQuery,
        RoundedRectangleBorder,
        ScaffoldMessenger,
        Size,
        SnackBar,
        SnackBarAction,
        SnackBarBehavior,
        Text,
        Widget;
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AppConfig {
  // static String baseUrl = "http://127.0.0.1/bwcc";
  static String baseUrl = "http://192.168.43.209/bwcc";
  // static String baseUrl = "https://bwcc.tncdigital.id";
  static String baseApiPath = "/api/1.0/";

  static String prefIsLogged = 'isLogged';
  static String prefUser = 'user';

  static int timeout = 60; // detik

  static Future<PackageInfo> getAppDetail() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }
}

class AppColors {
  // static Color softTeal = HexColor('#569aa1');
  static Color softTeal = HexColor('#4a9ea1');
  static Color softPink = HexColor('#e9739b');
  static Color softWhite = HexColor('#fefefe');
}

class AppAssets {
  static String basePath = 'assets/';
  static String imagePath = basePath + 'images/';
  static String logo = imagePath + 'logo_transparant.png';
  static String logoNew = imagePath + 'logo.png';
  static String logoWhite = imagePath + 'logo_white.png';
  static String backWhite = imagePath + 'back_white.png';
  static String backPink = imagePath + 'arrow_back.png';
  static String bgWave = imagePath + 'bg_wave.png';
  static String bgHeader = imagePath + 'bg_header.png';
  static String icLogo = imagePath + 'ic_logo.png';
  static String baby = imagePath + 'icon_anak.png';
}

class ApiService {
  static Future<http.Response> get(String path, {Map<String, String>? query}) async {
    try {
      var apiUrl = Urls.api(path);
      // logApp('ApiService GET => uri.authority => ${apiUrl.authority} ; uri.path => ${apiUrl.path}');
      apiUrl = Uri.http(apiUrl.authority, apiUrl.path, query);
      var response = await http
          .get(apiUrl, headers: await getApiHeaders())
          .timeout(Duration(seconds: AppConfig.timeout), onTimeout: _timeOut);
      logApp('Future<http.Response> GET $path $query => ' + response.body);
      return response;
    } catch (e) {
      logApp('Future<http.Response> GET $path ERROR => ' + e.toString());
      return http.Response(getMessage(e), 500);
    }
  }

  static Future<http.Response> post(String path, Map<String, String> query) async {
    try {
      var response = await http
          .post(Urls.api(path), body: query, headers: await getApiHeaders())
          .timeout(Duration(seconds: AppConfig.timeout), onTimeout: _timeOut);
      logApp('Future<http.Response> post $path $query => ' + response.body);
      return response;
    } catch (e) {
      logApp('Future<http.Response> post $path ERROR => ' + e.toString());
      return http.Response(getMessage(e), 500);
    }
  }

  static Future<http.Response> postMultipart(
    Uri url, {
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      var request = http.MultipartRequest('POST', url);
      if (fields != null) {
        request.fields.addAll(fields);
      }
      if (files != null) {
        request.files.addAll(files);
      }
      var streamedResponse = await request.send().timeout(
            Duration(seconds: AppConfig.timeout),
            onTimeout: _timeOutStream,
          );

      var response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      return http.Response(getMessage(e), 500);
    }
  }

  static Future<Map<String, String>> getApiHeaders() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token;

    try {
      String dataUser = preferences.getString(AppConfig.prefUser)!;
      User user = User();
      // logApp('getApiHeaders => ' + dataUser);
      user = User.fromJson(jsonDecode(dataUser));
      token = user.accessToken;
    } catch (e) {
      logApp('ERROR AT getApiHeaders => ' + e.toString());
    }

    var headers = {
      // 'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // logApp('getApiHeaders => ' + jsonEncode(headers));
    return headers;
  }

  static FutureOr<http.Response> _timeOut() {
    throw 'timeout';
  }

  static FutureOr<http.StreamedResponse> _timeOutStream() {
    throw 'timeout';
  }
}

removeData(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.remove(key);
}

saveData<T>(String key, T value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  switch (T) {
    case String:
      logApp('save data String => $value');
      preferences.setString(key, value as String);
      break;
    case bool:
      logApp('save data bool => $value');
      preferences.setBool(key, value as bool);
      break;
    case int:
      logApp('save data int => $value');
      preferences.setInt(key, value as int);
      break;
    case double:
      logApp('save data double => $value');
      preferences.setDouble(key, value as double);
      break;
    case List<String>:
      logApp('save data List => $value');
      preferences.setStringList(key, value as List<String>);
      break;
    default:
      logApp('save data default => $value');
      preferences.setString(key, value.toString());
  }
}

getData<T>(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var tmp = null;
  switch (T) {
    case String:
      tmp = preferences.getString(key);
      logApp('get data String => $key $tmp');
      break;
    case bool:
      tmp = preferences.getBool(key);
      logApp('get data bool => $key $tmp');
      break;
    case int:
      tmp = preferences.getInt(key);
      logApp('get data int => $key $tmp');
      break;
    case double:
      tmp = preferences.getDouble(key);
      logApp('get data double => $key $tmp');
      break;
    case List<String>:
      tmp = preferences.getStringList(key);
      logApp('get data List => $key $tmp');
      break;
    default:
      tmp = preferences.getString(key);
      logApp('get data default => $key $tmp');
  }
  return tmp;
}

routeTo(Widget page) {
  return MaterialPageRoute(builder: (context) => page);
}

Size mediaSize(context) {
  return MediaQuery.of(context).size;
}

class Urls {
  static Uri api(String route) => Uri.parse(AppConfig.baseUrl + AppConfig.baseApiPath + route.trim());
  static String photo(String? name) => '${AppConfig.baseUrl}/profile/$name';
  static String getIcon(String? path) => '${AppConfig.baseUrl}$path';
}

String fileToBase64(String path) {
  var bytes = io.File(path).readAsBytesSync();
  return base64Encode(bytes);
}

validMail(String email) {
  bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  return emailValid;
}

double deg2rad(d) => (d * (pi / 180.0));

double rad2deg(r) => (r * (180.0 / pi));

double distanceCalculate(double lat1, double lon1, double lat2, double lon2) {
  double theta = lon1 - lon2;
  double miles = (sin(deg2rad(lat1)) * sin(deg2rad(lat2))) +
      (cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta)));
  miles = acos(miles);
  miles = rad2deg(miles);
  miles = miles * 60 * 1.1515;
  double kilometers = miles * 1.609344;
  double meters = kilometers * 1000;

  return meters;
}

logApp(String message) {
  developer.log(message, name: 'DR APP');
}

showSnackbar(context, String msg) {
  SnackBar snackBar = SnackBar(content: Text(msg));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showToast(context, String msg, {double position = 45}) {
  SnackBar snackBar = SnackBar(
    content: Text(msg),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    margin: EdgeInsets.only(bottom: position, right: 20, left: 20),
    action: SnackBarAction(
      label: 'TUTUP',
      textColor: Colors.pink,
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

uniqeKey(int length) {
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
    ),
  );
}

getMessage(e) {
  if (e.toString() == 'timeout') {
    return '{"condition":false,"message":"Timeout, jaringan terlalu lambat'
        ', mohon periksa jaringan anda.","results":null}';
  } else {
    return '{"condition":false,"message":"Sepertinya ada masalah,'
        ' Coba periksa jaringan anda","results":null}';
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
