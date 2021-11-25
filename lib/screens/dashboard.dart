// ignore_for_file: non_constant_identifier_names

//import 'dart:convert';

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxirev/customecolors/palete.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';
import 'package:taxirev/services/urbancar.dart';
import 'package:taxirev/services/saloncar.dart';
import 'package:taxirev/services/motorbike.dart';
import 'package:taxirev/services/tricycle.dart';

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
    SunmiPrinter.hr(); // prints a full width separator
    SunmiPrinter.text(
      'Test Sunmi Printer',
      styles: const SunmiStyles(align: SunmiAlign.center),
    );
    SunmiPrinter.hr();

// Test align
    SunmiPrinter.text(
      'left',
      styles: const SunmiStyles(bold: true, underline: true),
    );
    SunmiPrinter.text(
      'center',
      styles: const SunmiStyles(
          bold: true, underline: true, align: SunmiAlign.center),
    );
    SunmiPrinter.text(
      'right',
      styles: const SunmiStyles(
          bold: true, underline: true, align: SunmiAlign.right),
    );

// Test text size
    SunmiPrinter.text('Extra small text',
        styles: const SunmiStyles(size: SunmiSize.xs));
    SunmiPrinter.text('Medium text',
        styles: const SunmiStyles(size: SunmiSize.md));
    SunmiPrinter.text('Large text',
        styles: const SunmiStyles(size: SunmiSize.lg));
    SunmiPrinter.text('Extra large text',
        styles: const SunmiStyles(size: SunmiSize.xl));

// Test row
    SunmiPrinter.row(
      cols: [
        SunmiCol(text: 'col1', width: 4),
        SunmiCol(text: 'col2', width: 4, align: SunmiAlign.center),
        SunmiCol(text: 'col3', width: 4, align: SunmiAlign.right),
      ],
    );
    // Test image
    ByteData bytes = await rootBundle.load('images/r2.png');
    final buffer = bytes.buffer;
    final imgData = base64.encode(Uint8List.view(buffer));
    SunmiPrinter.image(imgData);

    SunmiPrinter.row();
  }

  //Salon Text Controlls
  TextEditingController CarId = TextEditingController();
  TextEditingController Desc = TextEditingController();
  TextEditingController Amount = TextEditingController();

  //Urvan Text Controls
  TextEditingController UrvanId = TextEditingController();
  TextEditingController UrvanDesc = TextEditingController();
  TextEditingController UrAmount = TextEditingController();

  //Motor bike text controls
  TextEditingController MotorId = TextEditingController();
  TextEditingController MotorDesc = TextEditingController();
  TextEditingController MotorAmount = TextEditingController();

  //Motor bike text controls
  TextEditingController TriId = TextEditingController();
  TextEditingController TriDesc = TextEditingController();
  TextEditingController TriAmount = TextEditingController();

  late Future<Salon> futureSalon;
  late Future<Urban> futureUrban;
  late Future<Motor> futureMotor;
  late Future<Tri> futureTri;
  @override
  void initState() {
    futureSalon = fetchSalon();
    futureUrban = fetchUrban();
    futureMotor = fetchMotor();
    futureTri = fetchTri();
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
                      FutureBuilder<Salon>(
                        future: fetchSalon(),
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
                                        label: Text('ID'),
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
                                        label: Text('Type'),
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
                            return const Text("Please check your internet");
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_1_rounded),
                            label: Text('Sales Person'),
                            border: OutlineInputBorder()),
                        readOnly: true,
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
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      FutureBuilder<Urban>(
                        future: fetchUrban(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            UrvanId.text = snapshot.data!.id.toString();
                            UrvanDesc.text =
                                snapshot.data!.description.toString();
                            UrAmount.text = snapshot.data!.amount.toString();
                            return Form(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: UrvanId,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.info_outlined),
                                        label: Text('ID'),
                                        border: OutlineInputBorder()),
                                    readOnly: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: UrvanDesc,
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.car_repair_rounded),
                                        label: Text('Type'),
                                        border: OutlineInputBorder()),
                                    readOnly: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: UrAmount,
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
                            return const Text("Please check your internet");
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_1_rounded),
                            label: Text('Sales Person'),
                            border: OutlineInputBorder()),
                        readOnly: true,
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
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      FutureBuilder<Motor>(
                        future: fetchMotor(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            MotorId.text = snapshot.data!.id.toString();
                            MotorDesc.text =
                                snapshot.data!.description.toString();
                            MotorAmount.text = snapshot.data!.amount.toString();
                            return Form(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: MotorId,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.info_outlined),
                                        label: Text('ID'),
                                        border: OutlineInputBorder()),
                                    readOnly: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: MotorDesc,
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.car_repair_rounded),
                                        label: Text('Type'),
                                        border: OutlineInputBorder()),
                                    readOnly: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: MotorAmount,
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
                            return const Text("Please check your internet");
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_1_rounded),
                            label: Text('Sales Person'),
                            border: OutlineInputBorder()),
                        readOnly: true,
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
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      FutureBuilder<Tri>(
                        future: fetchTri(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            TriId.text = snapshot.data!.id.toString();
                            TriDesc.text =
                                snapshot.data!.description.toString();
                            TriAmount.text = snapshot.data!.amount.toString();
                            return Form(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: TriId,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.info_outlined),
                                        label: Text('ID'),
                                        border: OutlineInputBorder()),
                                    readOnly: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: TriDesc,
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.car_repair_rounded),
                                        label: Text('Type'),
                                        border: OutlineInputBorder()),
                                    readOnly: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: TriAmount,
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
                            return const Text("Please check your internet");
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_1_rounded),
                            label: Text('Sales Person'),
                            border: OutlineInputBorder()),
                        readOnly: true,
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
