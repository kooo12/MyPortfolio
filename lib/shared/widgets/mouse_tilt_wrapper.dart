import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MouseTiltWrapper extends StatefulWidget {
  final Widget child;
  final double tiltIntensity;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;

  const MouseTiltWrapper({
    super.key,
    required this.child,
    this.tiltIntensity = 0.002,
    this.onEnter,
    this.onExit,
  });

  @override
  State<MouseTiltWrapper> createState() => _MouseTiltWrapperState();
}

class _MouseTiltWrapperState extends State<MouseTiltWrapper> {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  bool _isHovering = false;

  void _onHover(PointerEvent details) {
    if (!_isHovering) {
      setState(() => _isHovering = true);
    }

    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null && box.hasSize) {
      final size = box.size;
      final center = size.center(Offset.zero);
      final localPos = details.localPosition;

      final targetRotateY = (localPos.dx - center.dx) * widget.tiltIntensity;
      final targetRotateX = -(localPos.dy - center.dy) * widget.tiltIntensity;

      setState(() {
        _rotateX = targetRotateX;
        _rotateY = targetRotateY;
      });
    }
  }

  void _onEnter(PointerEnterEvent details) {
    setState(() => _isHovering = true);
    widget.onEnter?.call(details);
  }

  void _onExit(PointerExitEvent details) {
    setState(() {
      _isHovering = false;
      _rotateX = 0.0;
      _rotateY = 0.0;
    });
    widget.onExit?.call(details);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      onHover: _onHover,
      opaque: false,
      hitTestBehavior: HitTestBehavior.translucent,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 0.0, end: _isHovering ? 1.0 : 0.0),
        builder: (context, hoverFactor, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_rotateX * hoverFactor)
              ..rotateY(_rotateY * hoverFactor),
            alignment: Alignment.center,
            child: widget.child,
          );
        },
      ),
    );
  }
}
