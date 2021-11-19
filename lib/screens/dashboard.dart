// ignore_for_file: non_constant_identifier_names

//import 'dart:convert';

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxirev/customecolors/palete.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';
import 'package:taxirev/services/saloncar.dart';

// ignore: import_of_legacy_library_into_null_safe
//import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void _print() async {
    // Test regular text
    //

    // Test image
    ByteData bytes = await rootBundle.load('images/r2.png');
    final buffer = bytes.buffer;
    final imgData = base64.encode(Uint8List.view(buffer));
    SunmiPrinter.image(imgData);

    SunmiPrinter.row();
  }

  TextEditingController CarId = TextEditingController();
  TextEditingController Desc = TextEditingController();
  TextEditingController Amount = TextEditingController();
  late Future<Album> futureAlbum;
  @override
  void initState() {
    futureAlbum = fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: AppBar(
            title: const Text('eREV 1.0'),
            elevation: 0,
            backgroundColor: Palette.kToDark,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Salon Car',
                  icon: Icon(Icons.car_rental_rounded),
                ),
                Tab(
                  text: 'Urvan Buses',
                  icon: Icon(Icons.bus_alert_rounded),
                ),
                Tab(text: 'Motor Bikes', icon: Icon(Icons.motorcycle_rounded)),
                Tab(
                  text: 'Tricycle',
                  icon: Icon(Icons.bike_scooter),
                ),
              ],
            ),
          ),
          body: Center(
            child: TabBarView(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      FutureBuilder<Album>(
                        future: fetchAlbum(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            CarId.text = snapshot.data!.id.toString();
                            Desc.text = snapshot.data!.description.toString();
                            Amount.text = snapshot.data!.amount.toString();
                            return Form(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: CarId,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.info_outlined),
                                        label: Text('Car ID'),
                                        border: OutlineInputBorder()),
                                    readOnly: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: Desc,
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.car_repair_rounded),
                                        label: Text('Car Type'),
                                        border: OutlineInputBorder()),
                                    readOnly: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: Amount,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.money),
                                        label: Text('Amount'),
                                        border: OutlineInputBorder()),
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Text(
                                "No data fetched!Please try again");
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: _print,
                        icon: const Icon(Icons.print),
                        label: const Text('Print Receipt'),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            primary: Palette.kToDark,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                      )
                    ],
                  ),
                )),
                const Center(child: Text('Urvan Buses')),
                const Center(child: Text('Motor Bikes')),
                const Center(child: Text('Tricycle')),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.support_agent_outlined), label: 'Support')
          ]),
        ));
  }
}
