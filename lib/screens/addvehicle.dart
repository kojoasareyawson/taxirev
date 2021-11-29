import 'package:flutter/material.dart';
import 'package:taxirev/screens/dashboard.dart';

class Addvehicle extends StatefulWidget {
  const Addvehicle({Key? key}) : super(key: key);

  @override
  _AddvehicleState createState() => _AddvehicleState();
}

class _AddvehicleState extends State<Addvehicle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Vehicle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
              );
            },
          )
        ],
      ),
      body: (Column()),
    );
  }
}
