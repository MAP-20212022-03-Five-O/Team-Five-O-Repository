import 'package:flutter/material.dart';

class CarTab extends StatefulWidget {
  const CarTab({Key? key}) : super(key: key);

  @override
  State<CarTab> createState() => _CarTabState();
}

class _CarTabState extends State<CarTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'My Car',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          )),
    );
  }
}
