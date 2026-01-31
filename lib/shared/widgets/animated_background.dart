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
  late List<_Particle> _particles;
  Size? _lastSize;

  @override
  void initState() {
    super.initState();
    _particles = List.generate(25, (index) => _Particle());

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(_updateParticles);
    _controller.repeat();
  }

  void _updateParticles() {
    if (_lastSize == null) return;
    setState(() {
      for (final particle in _particles) {
        particle.update(_lastSize!);
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateParticles);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        if (_lastSize != size) {
          _lastSize = size;
          for (final particle in _particles) {
            particle.initPosition(size);
          }
        }

        return Container(
          decoration: const BoxDecoration(gradient: AppColors.bgGradient),
          child: CustomPaint(
            painter: _ParticlePainter(_particles),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}

class _Particle {
  late double x;
  late double y;
  late double speedX;
  late double speedY;
  final double size = Random().nextDouble() * 200 + 100;
  final Color color = [
    AppColors.primary.withValues(alpha: 0.1),
    AppColors.accent.withValues(alpha: 0.1),
    AppColors.warmTeal.withValues(alpha: 0.1),
  ][Random().nextInt(3)];

  bool _isInitialized = false;

  void initPosition(Size canvasSize) {
    if (!_isInitialized) {
      x = Random().nextDouble() * canvasSize.width;
      y = Random().nextDouble() * canvasSize.height;
      speedX = (Random().nextDouble() - 0.5) * 1.5;
      speedY = (Random().nextDouble() - 0.5) * 1.5;
      _isInitialized = true;
    }
  }

  void update(Size canvasSize) {
    x += speedX;
    y += speedY;

    if (x < -size) x = canvasSize.width + size;
    if (x > canvasSize.width + size) x = -size;
    if (y < -size) y = canvasSize.height + size;
    if (y > canvasSize.height + size) y = -size;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);

    for (final particle in particles) {
      paint.color = particle.color;
      canvas.drawCircle(Offset(particle.x, particle.y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
