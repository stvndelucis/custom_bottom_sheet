import 'dart:developer';

import 'package:bottom_sheet_example/frontend/custom_widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomSheet: CustomBottomSheet(
        minHeight: 0.3,
        maxHeight: 0.9,
        child: Center(child: Text('Hello')),
      ),
    );
  }
}
