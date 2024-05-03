import 'package:flutter/material.dart';

class DMScreen extends StatefulWidget {
  const DMScreen({super.key});

  @override
  State<DMScreen> createState() => DMScreenState();
}

class DMScreenState extends State<DMScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: _buildUi(),
        ),
      ),
    );
  }

  Widget _buildUi() {
    return const Placeholder();
  }
}