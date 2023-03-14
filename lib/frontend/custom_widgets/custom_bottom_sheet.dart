import 'dart:developer';

import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget child;
  final double minHeight, maxHeight, initialHeight;

  const CustomBottomSheet({
    super.key,
    required this.child,
    this.minHeight = 0.3,
    this.maxHeight = 1.0,
    this.initialHeight = 0.5,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late final double _screenHeight;
  double _dragPercentage = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenHeight = MediaQuery.of(context).size.height;
      _dragPercentage = widget.initialHeight;
      // _height = _screenHeight * _dragPercentage;
      // log('$_height');
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    // _startPosition = details.globalPosition.dy;
    // log('${details.globalPosition.dy}', name: 'VERTICAL DRAG START | drag position dy');
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    final newPosition = details.globalPosition.dy;
    // _dragPercentage = (100 - ((newPosition / _screenHeight) * 100)).clamp(widget.minHeight, widget.maxHeight);
    // _dragPercentage = ((newPosition / _screenHeight) * 100).clamp(widget.minHeight * 100, widget.maxHeight * 100) / 100;
    _dragPercentage =
        (((_screenHeight - newPosition) / _screenHeight) * 100).clamp(widget.minHeight * 100, widget.maxHeight * 100) /
            100;
    log('$_dragPercentage', name: 'DRAG PERCENTAGE');

    setState(() {
      // _height = _screenHeight * _dragPercentage;
    });

    // final delta = newPosition - _startPosition;
    // log('$delta', name: 'VERTICAL DRAG UPDATE | delta');

    // final newHeight = _height - delta;
    // setState(() {
    //   _height = newHeight.clamp(widget.minHeight, widget.maxHeight);
    //   _startPosition = newPosition;
    // });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    // Optional: Add animation to snap to the closest height value
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onTap: () {},
      // onVerticalDragEnd: _onVerticalDragEnd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        height: MediaQuery.of(context).size.height * _dragPercentage,
        child: widget.child,
      ),
    );
  }
}
