import 'dart:math' as math;

import 'package:flutter/material.dart';

class AdvancedLoadingScreen extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final Color? primaryColor;
  final Color? secondaryColor;
  final LoadingType type;

  const AdvancedLoadingScreen({
    super.key,
    this.title,
    this.subtitle,
    this.primaryColor,
    this.secondaryColor,
    this.type = LoadingType.circular,
  });

  @override
  State<AdvancedLoadingScreen> createState() => _AdvancedLoadingScreenState();
}

enum LoadingType { circular, dots, wave, pulse }

class _AdvancedLoadingScreenState extends State<AdvancedLoadingScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get primaryColor => widget.primaryColor ?? const Color(0xFF667EEA);
  Color get secondaryColor => widget.secondaryColor ?? const Color(0xFF764BA2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: BackdropFilter(
        filter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.darken,
        ),
        child: Center(
          child: Container(
            width: 220,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Loader based on type
                _buildLoader(),

                const SizedBox(height: 25),

                // Title
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),

                const SizedBox(height: 8),

                // Subtitle
                if (widget.subtitle != null)
                  Text(
                    widget.subtitle!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    switch (widget.type) {
      case LoadingType.circular:
        return _buildCircularLoader();
      case LoadingType.dots:
        return _buildDotsLoader();
      case LoadingType.wave:
        return _buildWaveLoader();
      case LoadingType.pulse:
        return _buildPulseLoader();
    }
  }

  Widget _buildCircularLoader() {
    return SizedBox(
      width: 60,
      height: 60,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        strokeWidth: 4,
        backgroundColor: secondaryColor.withOpacity(0.3),
      ),
    );
  }

  Widget _buildDotsLoader() {
    return SizedBox(
      width: 60,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(
                  _controller.value > index / 3 && _controller.value <= (index + 1) / 3
                      ? 1.0
                      : 0.3
              ),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWaveLoader() {
    return SizedBox(
      width: 60,
      height: 40,
      child: CustomPaint(
        painter: _WavePainter(_controller, primaryColor),
      ),
    );
  }

  Widget _buildPulseLoader() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      width: 40 + (20 * _controller.value),
      height: 40 + (20 * _controller.value),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.7 - (_controller.value * 0.4)),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.shopping_bag_rounded,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  _WavePainter(this.animation, this.color) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = size.height * 0.3;
    final baseHeight = size.height / 2;

    for (double i = 0; i < size.width; i++) {
      final x = i;
      final y = baseHeight +
          waveHeight *
              math.sin((i / size.width * 2 * math.pi) + animation.value * 2 * math.pi);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}