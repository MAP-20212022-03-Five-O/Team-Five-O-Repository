import 'package:five_o_car_rental/Models/rent.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/pdf_export.dart';
import 'package:flutter/material.dart';

import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final Rent rent;
  const PdfPreviewPage({Key? key, required this.rent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(rent),
      ),
    );
  }
}
