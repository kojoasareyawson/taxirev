import 'package:flutter/material.dart';
import 'package:taxirev/customecolors/palete.dart';
import 'package:flutter/widgets.dart';
import 'package:taxirev/services/urbancar.dart';
import 'package:taxirev/services/saloncar.dart';
import 'package:taxirev/services/motorbike.dart';
import 'package:taxirev/services/tricycle.dart';
import 'package:taxirev/controls/textcontrols.dart';
import 'package:taxirev/sunmi/sunmiprint.dart';
import 'package:taxirev/screens/addvehicle.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                        onPressed: print,
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
                        onPressed: print,
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
                        onPressed: print,
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
                        onPressed: print,
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Addvehicle(),
                ),
              );
            },
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
