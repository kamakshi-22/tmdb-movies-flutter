import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphicBackground extends StatelessWidget {
  final Widget child;
  const GlassmorphicBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05)
              ])),
          child: child,
        ),
      ),
    );
  }
}
