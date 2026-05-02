import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  bool get _isNetwork =>
      path.startsWith('http') ||
      path.startsWith('https') ||
      path.startsWith('data');

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('data:')) {
      return RepaintBoundary(
        child: Image.network(
          path,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
              errorWidget ?? const Center(child: Icon(Icons.error_outline)),
        ),
      );
    } else if (_isNetwork) {
      return RepaintBoundary(
        child: CachedNetworkImage(
          imageUrl: path,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) =>
              placeholder ??
              const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
          errorWidget: (context, url, error) =>
              errorWidget ?? const Center(child: Icon(Icons.error_outline)),
        ),
      );
    } else {
      return RepaintBoundary(
        child: Image.asset(
          path,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ??
                const Center(child: Icon(Icons.broken_image_outlined));
          },
        ),
      );
    }
  }
}
