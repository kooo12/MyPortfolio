import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_portfolio/core/theme/app_colors.dart';
import 'package:new_portfolio/features/portfolio/presentation/shared/widgets/glass_container.dart';

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                      _NavItem(label: 'Home', isSelected: false, onTap: () {}),
                      _NavItem(label: 'About', isSelected: false, onTap: () {}),
                      _NavItem(
                        label: 'Experience',
                        isSelected: false,
                        onTap: () {},
                      ),
                      _NavItem(
                        label: 'Skills',
                        isSelected: false,
                        onTap: () {},
                      ),
                      _NavItem(
                        label: 'Projects',
                        isSelected: false,
                        onTap: () {},
                      ),
                      _NavItem(
                        label: 'Contact',
                        isSelected: false,
                        onTap: () {},
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
