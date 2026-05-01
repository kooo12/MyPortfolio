import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_portfolio/core/theme/app_colors.dart';
import 'package:new_portfolio/features/portfolio/presentation/providers/scroll_provider.dart';

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollState = ref.watch(scrollProvider);
    final activeIndex = scrollState.activeIndex;
    final scrollOffset = scrollState.scrollOffset;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    final bgOpacity = (scrollOffset / 200).clamp(0.0, 0.8);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: RepaintBoundary(
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF121212).withValues(alpha: bgOpacity),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.05 * bgOpacity),
              ),
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: (20 * bgOpacity).clamp(0.01, 20.0),
                sigmaY: (20 * bgOpacity).clamp(0.01, 20.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 96,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand
                    Text(
                      'DevPortfolio',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),

                    if (!isMobile) ...[
                      // Nav Links
                      Row(
                        children: [
                          _NavLink(
                            label: 'Home',
                            isActive: activeIndex == 0,
                            onTap: () => ref
                                .read(scrollProvider.notifier)
                                .scrollToSection(0),
                          ),
                          _NavLink(
                            label: 'Projects',
                            isActive: activeIndex == 2,
                            onTap: () => ref
                                .read(scrollProvider.notifier)
                                .scrollToSection(2),
                          ),
                          _NavLink(
                            label: 'Experience',
                            isActive: activeIndex == 3,
                            onTap: () => ref
                                .read(scrollProvider.notifier)
                                .scrollToSection(3),
                          ),
                          _NavLink(
                            label: 'Contact',
                            isActive: activeIndex == 4,
                            onTap: () => ref
                                .read(scrollProvider.notifier)
                                .scrollToSection(4),
                          ),
                        ],
                      ),

                      // Resume Button
                      const _ResumeButton(),
                    ],

                    if (isMobile)
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu, color: Colors.white),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  color: widget.isActive
                      ? AppColors.accent
                      : const Color(0xFF9CA3AF),
                  fontWeight:
                      widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 24 : 0,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  const _ResumeButton();

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(4),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryContainer.withValues(alpha: 0.3),
                    blurRadius: 15,
                  ),
                ]
              : [],
        ),
        child: Text(
          'Resume',
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
