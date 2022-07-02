import 'dart:typed_data';
import 'package:five_o_car_rental/Models/rent.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

Future<Uint8List> makePdf(Rent rent) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List());
  String startDate = DateFormat('dd-MM-yyyy').format(rent.startDate!);
  String endDate = DateFormat('dd-MM-yyyy').format(rent.endDate!);
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Attention to Renter ID: ${rent.renterid}"),
                    // Text(rent.email),
                    // Text(rent.phoneNo),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'INVOICE FOR PAYMENT',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: PaddedText('Car Brand/Model'),
                      flex: 2,
                    ),
                    Expanded(
                      child: PaddedText(rent.brand!),
                      flex: 1,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: PaddedText('Vehicle Plate Number'),
                      flex: 2,
                    ),
                    Expanded(
                      child: PaddedText(rent.plateNo!),
                      flex: 1,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: PaddedText('Rental Date'),
                      flex: 2,
                    ),
                    Expanded(
                      child: PaddedText('Rent Date: $startDate until $endDate'),
                      flex: 1,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText('Total Payment', align: TextAlign.right),
                    PaddedText('RM${(rent.totalPayment)}')
                  ],
                )
              ],
            ),
            Padding(
              child: Text(
                "THANK YOU FOR YOUR BOOKING!",
                style: Theme.of(context).header2,
              ),
              padding: const EdgeInsets.all(20),
            ),
            Text(
                "Please forward the below slip to your accounts payable department."),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText('Account Number'),
                    PaddedText(
                      '1234 1234',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Owner ID',
                    ),
                    PaddedText(
                      rent.ownerid!,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Total Amount to be Paid',
                    ),
                    PaddedText('\$${rent.totalPayment}')
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                'Please ensure all cheques are payable to the vehicle owner.',
                style: Theme.of(context).header3.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
