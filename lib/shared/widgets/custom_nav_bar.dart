import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_portfolio/core/theme/app_colors.dart';
import 'package:new_portfolio/features/portfolio/presentation/providers/scroll_provider.dart';
import 'glass_container.dart';

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollState = ref.watch(scrollProvider);
    final activeIndex = scrollState.activeIndex;
    final scrollOffset = scrollState.scrollOffset;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    final brandingOpacity = (scrollOffset / 300).clamp(0.0, 1.0);

    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Opacity(
                opacity: brandingOpacity,
                child: GlassContainer(
                  borderRadius: 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Text(
                      'AUNG KO OO',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20),

            if (!isMobile)
              GlassContainer(
                borderRadius: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NavItem(
                        label: 'Home',
                        isSelected: activeIndex == 0,
                        onTap: () => ref
                            .read(scrollProvider.notifier)
                            .scrollToSection(0),
                      ),
                      _NavItem(
                        label: 'About',
                        isSelected: activeIndex == 1,
                        onTap: () => ref
                            .read(scrollProvider.notifier)
                            .scrollToSection(1),
                      ),
                      _NavItem(
                        label: 'Experience',
                        isSelected: activeIndex == 2,
                        onTap: () => ref
                            .read(scrollProvider.notifier)
                            .scrollToSection(2),
                      ),
                      _NavItem(
                        label: 'Skills',
                        isSelected: activeIndex == 3,
                        onTap: () => ref
                            .read(scrollProvider.notifier)
                            .scrollToSection(3),
                      ),
                      _NavItem(
                        label: 'Projects',
                        isSelected: activeIndex == 4,
                        onTap: () => ref
                            .read(scrollProvider.notifier)
                            .scrollToSection(4),
                      ),
                      _NavItem(
                        label: 'Contact',
                        isSelected: activeIndex == 5,
                        onTap: () => ref
                            .read(scrollProvider.notifier)
                            .scrollToSection(5),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
