import 'package:flutter/material.dart';
import 'reset_body.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);
  static Route route() => MaterialPageRoute(builder: (_) => const ResetPage());

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  @override
  Widget build(BuildContext context) {
    return resetBody(context);
  }
}
