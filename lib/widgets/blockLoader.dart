import 'dart:math';

import 'package:flutter/material.dart';

class BlockLoader extends StatefulWidget {
  @override
  _BlockLoaderState createState() => _BlockLoaderState();
}

class _BlockLoaderState extends State<BlockLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => listItems(),
    );
  }

  Widget tile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 15,
            width: 100,
            color: Colors.grey[300],
          ),
          Container(
            height: 15,
            width: 20,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget listItems() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            decoration: decoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    height: 15,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [Colors.grey[100]!, Colors.grey[200]!],
                        stops: [0, _animationController.value],
                      ),
                    ),
                  ),
                ),
                tile(),
                tile(),
                tile(),
              ],
            ),
          ),
        );
      },
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        transform: const GradientRotation(pi / 4.5),
        colors: [
          Colors.white,
          Colors.grey[200]!,
        ],
        stops: [
          0,
          _animationController.value,
        ],
      ),
    );
  }
}
