import 'dart:convert';
import 'package:ecommerce/auth/login_page.dart';
import 'package:ecommerce/shop/product_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../API/api.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../tabs_screen.dart';

SnackBar snackBar(message, color) {
  return SnackBar(
      duration: const Duration(seconds: 4),
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(fontSize: 18),
      ));
}

Future httppostsignup(
    String url, Map<String, dynamic> data, BuildContext context) async {
  try {
    var vardata = data;

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(vardata),
    );

    var jsonResponse = json.decode(response.body);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == Api.codeOK) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      return jsonResponse;
    } else {
      var res = jsonResponse as Map;

      if (res.keys.elementAt(0) == "name") {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar(jsonResponse["name"][0], Colors.red[500]));
      } else if (res.keys.elementAt(0) == "email") {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar(jsonResponse["email"][0], Colors.red[500]));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBar(jsonResponse["password"][0], Colors.red[500]));
      }

      return jsonResponse;
    }
  } catch (e) {}
}

Future httppostlogin(
    String url, Map<String, dynamic> data, BuildContext context) async {
  try {
    var vardata = data;

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(vardata),
    );

    var jsonResponse = json.decode(response.body);

    if (response.statusCode == Api.codeOK) {
      Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      return jsonResponse;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar(jsonResponse["message"], Colors.red[500]));
      // Future.delayed(const Duration(seconds: 1)).then((value) {});

      return jsonResponse;
    }
  } catch (e) {}
}

Future httppost(String token, String url, BuildContext context) async {
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response.body;
  } catch (e) {}
}

pref(string, data) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.setString(string, data);
}
