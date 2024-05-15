import 'dart:math';

import 'package:flutter/material.dart';

import 'colors.dart';

class LoaderScaffold extends StatelessWidget {
  const LoaderScaffold({super.key, required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: LoaderContainerWithMessage(
          message: msg,
        ),
      ),
    );
  }
}

class LoaderContainerWithMessage extends StatefulWidget {
  final double radius;
  final String message;
  const LoaderContainerWithMessage({super.key, this.radius = 25.0, required this.message});

  @override
  LoaderContainerWithMessageState createState() => LoaderContainerWithMessageState();
}

class LoaderContainerWithMessageState extends State<LoaderContainerWithMessage> with SingleTickerProviderStateMixin {
  late Animation<double> animationRotation;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;
  late AnimationController controller;

  late double radius;
  @override
  void initState() {
    super.initState();

    radius = widget.radius;

    controller = AnimationController(lowerBound: 0.0, upperBound: 1.0, duration: const Duration(milliseconds: 3000), vsync: this);

    animationRotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animationRadiusIn = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animationRadiusOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = widget.radius * animationRadiusIn.value;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = widget.radius * animationRadiusOut.value;
        }
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: animationRotation,
            child: Stack(
              children: List.generate(8, (index) {
                final angle = 2 * pi * index / 8;
                return Transform.translate(
                  offset: Offset(
                    radius * cos(angle),
                    radius * sin(angle),
                  ),
                  child: const Dot(
                    radius: 8,
                    color: primaryColor,
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 50, 8, 0),
            child: Text(widget.message, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;

  const Dot({super.key, this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
