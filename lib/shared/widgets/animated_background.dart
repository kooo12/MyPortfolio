import 'dart:math';
import 'package:flutter/material.dart';
import 'package:new_portfolio/core/theme/app_colors.dart';

/// Lightweight animated background with fewer, slower particles
/// and reduced blur for better scroll performance on web.
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
    // Reduced from 25 to 12 particles for performance
    _particles = List.generate(12, (index) => _Particle());

    _controller = AnimationController(
      vsync: this,
      // Slower animation = fewer repaints
      duration: const Duration(seconds: 4),
    )..addListener(_updateParticles);
    _controller.repeat();
  }

  void _updateParticles() {
    if (_lastSize == null) return;
    for (final particle in _particles) {
      particle.update(_lastSize!);
    }
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
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _ParticlePainter(_particles, _controller),
              size: Size.infinite,
              isComplex: true,
              willChange: true,
            ),
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
  // Smaller particles = less area to blur
  final double size = Random().nextDouble() * 120 + 60;
  final Color color = [
    AppColors.primary.withValues(alpha: 0.04),
    AppColors.accent.withValues(alpha: 0.03),
    AppColors.primaryContainer.withValues(alpha: 0.03),
  ][Random().nextInt(3)];

  bool _isInitialized = false;

  void initPosition(Size canvasSize) {
    if (!_isInitialized) {
      x = Random().nextDouble() * canvasSize.width;
      y = Random().nextDouble() * canvasSize.height;
      // Slower movement
      speedX = (Random().nextDouble() - 0.5) * 0.8;
      speedY = (Random().nextDouble() - 0.5) * 0.8;
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
  // Reduced blur sigma from 50 to 30 for performance
  final Paint _paint = Paint()
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

  _ParticlePainter(this.particles, Listenable repaint)
    : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      _paint.color = particle.color;
      canvas.drawCircle(Offset(particle.x, particle.y), particle.size, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
