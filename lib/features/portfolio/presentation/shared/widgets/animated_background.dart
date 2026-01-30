import 'dart:math';
import 'package:flutter/material.dart';
import 'package:new_portfolio/core/theme/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = List.generate(20, (index) => _Particle());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(gradient: AppColors.bgGradient),
          child: CustomPaint(
            painter: _ParticlePainter(_particles, _controller.value),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}

class _Particle {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double size = Random().nextDouble() * 200 + 100;
  Color color = [
    AppColors.primary.withValues(alpha: 0.1),
    AppColors.accent.withValues(alpha: 0.1),
    AppColors.warmTeal.withValues(alpha: 0.1),
  ][Random().nextInt(3)];
  double speedX = (Random().nextDouble() - 0.5) * 0.05;
  double speedY = (Random().nextDouble() - 0.5) * 0.05;
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double animationValue;

  _ParticlePainter(this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final x =
          (particle.x + particle.speedX * animationValue * 10) %
          1.0 *
          size.width;
      final y =
          (particle.y + particle.speedY * animationValue * 10) %
          1.0 *
          size.height;

      final paint = Paint()
        ..color = particle.color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);

      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
