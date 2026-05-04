import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_portfolio/core/theme/app_colors.dart';
import 'package:new_portfolio/features/portfolio/presentation/providers/scroll_provider.dart';

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(
      scrollProvider.select((s) => s.controller),
    );
    final activeIndex = ref.watch(scrollProvider.select((s) => s.activeIndex));
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ListenableBuilder(
        listenable: scrollController,
        builder: (context, child) {
          final scrollOffset = scrollController.hasClients
              ? scrollController.offset
              : 0.0;
          final bgOpacity = (scrollOffset / 200).clamp(0.0, 0.8);

          return RepaintBoundary(
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
                  child: child,
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 96),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.5),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    activeIndex > 0 ? 'AUNG KO OO' : 'Flutter Developer',
                    key: ValueKey<bool>(activeIndex > 0),
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: activeIndex > 0 ? 1.5 : -0.5,
                    ),
                  ),
                ),
              ),

              if (!isMobile) ...[
                Row(
                  children: [
                    _NavLink(
                      label: 'Home',
                      isActive: activeIndex == 0,
                      onTap: () =>
                          ref.read(scrollProvider.notifier).scrollToSection(0),
                    ),
                    _NavLink(
                      label: 'Projects',
                      isActive: activeIndex == 2,
                      onTap: () =>
                          ref.read(scrollProvider.notifier).scrollToSection(2),
                    ),
                    _NavLink(
                      label: 'Experience',
                      isActive: activeIndex == 3,
                      onTap: () =>
                          ref.read(scrollProvider.notifier).scrollToSection(3),
                    ),
                    _NavLink(
                      label: 'Contact',
                      isActive: activeIndex == 4,
                      onTap: () =>
                          ref.read(scrollProvider.notifier).scrollToSection(4),
                    ),
                  ],
                ),

                const _ResumeButton(),
              ],

              if (isMobile)
                IconButton(
                  onPressed: () => _showMobileMenu(context, ref, activeIndex),
                  icon: const Icon(Icons.menu, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, WidgetRef ref, int activeIndex) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:
                  [
                        Center(
                          child: Container(
                            width: 48,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 32),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        _buildMobileNavItem(
                          context,
                          ref,
                          'Home',
                          0,
                          activeIndex,
                        ),
                        _buildMobileNavItem(
                          context,
                          ref,
                          'Projects',
                          2,
                          activeIndex,
                        ),
                        _buildMobileNavItem(
                          context,
                          ref,
                          'Experience',
                          3,
                          activeIndex,
                        ),
                        _buildMobileNavItem(
                          context,
                          ref,
                          'Contact',
                          4,
                          activeIndex,
                        ),
                        const SizedBox(height: 32),
                        const Center(child: _ResumeButton()),
                        const SizedBox(height: 16),
                      ]
                      .animate(interval: 50.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic)
                      .fadeIn(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileNavItem(
    BuildContext context,
    WidgetRef ref,
    String label,
    int index,
    int activeIndex,
  ) {
    final isActive = activeIndex == index;
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ref.read(scrollProvider.notifier).scrollToSection(index);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: isActive ? AppColors.accent : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            fontSize: 18,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
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
                  fontWeight: widget.isActive
                      ? FontWeight.w600
                      : FontWeight.w400,
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
