import 'dart:developer';

import 'package:bottom_sheet_example/frontend/custom_widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _opacity = 1.0;
  double? _lastSheetPercentage;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomSheet: CustomBottomSheet(
          minHeight: 0.4,
          maxHeight: 0.9,
          onHeightChanged: (sheetPercentage) {
            if (_lastSheetPercentage != null) {
              if (sheetPercentage > _lastSheetPercentage!) {
                // Le bottom sheet monte
                _updateOpacity('decrease');
              } else if (sheetPercentage < _lastSheetPercentage!) {
                // Le bottom sheet descend
                _updateOpacity('increase');
              }
            } else {
              _lastSheetPercentage = sheetPercentage;

              _updateOpacity('decrease');
            }
          },
          child: Column(
            children: [
              //
              _buildHeader(),

              const SizedBox(height: 10.0),

              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 800),
                child: Container(
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _updateOpacity(String action) {
    if (action == 'decrease') {
      final newOpacity = _opacity - 0.1;
      if( newOpacity < 0) {
        _opacity = 0.0;
      } else{
        _opacity = newOpacity;
      }
    } else if (action == 'increase') {
      final newOpacity = _opacity + 0.1;
      if (newOpacity > 1.0) {
        _opacity = 1.0;
      }else {
        _opacity = newOpacity;
      }
    }
    setState(() {});
  }

  Widget _buildHeader() => SizedBox(
        height: 100.0,
        child: Row(
          children: [
            //
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),

            const SizedBox(width: 5.0),

            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),

            const SizedBox(width: 5.0),

            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),
          ],
        ),
      );
}
