import 'package:flutter/material.dart';

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({super.key});

  @override
  State<SuccessfulPage> createState() => _SuccessfulPage();
}

class _SuccessfulPage extends State<SuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(color: Colors.blue),
      ),
    );
  }
}
