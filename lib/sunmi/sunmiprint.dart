import 'package:flutter/material.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/services.dart';

void print() async {
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
    styles:
        const SunmiStyles(bold: true, underline: true, align: SunmiAlign.right),
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

  SunmiPrinter.emptyLines(3);
}
