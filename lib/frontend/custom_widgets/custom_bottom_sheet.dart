import 'dart:developer';

import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget child;
  final double minHeight, maxHeight, initialHeight;
  final ValueChanged<double> onHeightChanged;

  const CustomBottomSheet({
    super.key,
    required this.child,
    this.minHeight = 0.3,
    this.maxHeight = 1.0,
    this.initialHeight = 0.5,
    required this.onHeightChanged,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  // late final double _screenHeight;
  double _dragPercentage = 0.0;

  @override
  void initState() {
    super.initState();

    _dragPercentage = widget.initialHeight;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _screenHeight = MediaQuery.of(context).size.height;
      // _dragPercentage = widget.initialHeight;
      // _height = _screenHeight * _dragPercentage;
      // log('$_height');
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    // _newDragPosition = details.globalPosition.dy;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    final screenHeight = MediaQuery.of(context).size.height;
    final newPosition = details.globalPosition.dy;

    // _lastDragPosition = newPosition;

    setState(() {
      _dragPercentage = (((screenHeight - newPosition) / screenHeight) * 100)
              .clamp(widget.minHeight * 100, widget.maxHeight * 100) /
          100;
    });
    log('$_dragPercentage', name: 'DRAG PERCENTAGE');

    widget.onHeightChanged(_dragPercentage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onTap: () {}, // Pour annuler le fait de cliquer sans drag
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.linear,
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height * _dragPercentage,
          child: widget.child,
        ),
      ),
    );
  }
}
