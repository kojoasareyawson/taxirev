// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

Future<Salon> fetchSalon() async {
  final response = await http.get(
      'https://www.rehotek.com/service/taxirevService/API/public/api/carsid/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Salon.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load salon car');
  }
}

class Salon {
  final int id;
  final String description;
  final String amount;

  Salon({required this.id, required this.description, required this.amount});

  factory Salon.fromJson(Map<String, dynamic> json) {
    return Salon(
      id: json['id'],
      description: json['description'],
      amount: json['amount'],
    );
  }
}
