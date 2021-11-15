import 'package:flutter/material.dart';

Card makeDashboardItem(String title, IconButton iconButton) {
  IconData? icon;
  return Card(
    elevation: 1.0,
    margin: const EdgeInsets.all(8.0),
    child: Container(
      decoration:
          const BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            // ignore: unnecessary_const
            Center(
                child: Icon(
              icon,
              size: 40.0,
              color: Colors.black,
            )),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(title,
                  style: const TextStyle(fontSize: 18.0, color: Colors.black)),
            )
          ],
        ),
      ),
    ),
  );
}
