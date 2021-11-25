// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

Future<Urban> fetchUrban() async {
  final response = await http.get(
      'https://www.rehotek.com/service/taxirevService/API/public/api/carsid/2');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Urban.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to salon car');
  }
}

class Urban {
  final int id;
  final String description;
  final String amount;

  Urban({required this.id, required this.description, required this.amount});

  factory Urban.fromJson(Map<String, dynamic> json) {
    return Urban(
      id: json['id'],
      description: json['description'],
      amount: json['amount'],
    );
  }
}
