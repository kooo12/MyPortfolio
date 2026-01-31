import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_portfolio/features/portfolio/presentation/shared/widgets/glass_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/scroll_provider.dart';

class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollOffset = ref.watch(scrollProvider).scrollOffset;
    final size = MediaQuery.of(context).size;

    final isVisible = scrollOffset > size.height * 0.5;
    final padding = size.width < 600 ? 24.0 : 100.0;

    return Container(
      height: size.height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXPERIENCE',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.accent,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ).animate(target: isVisible ? 1 : 0).fadeIn().slideX(begin: -0.1),
          const SizedBox(height: 50),
          _ExperienceItem(
            company: 'Tech Plus Solutions (TPS)',
            role: 'Mid-Senior Flutter Developer',
            period: '2022 - Present',
            description:
                'Driving high-performance mobile solutions. Specialized in complex architectural patterns and performance profiling.',
            color: AppColors.primary,
            isVisible: isVisible,
            delay: 100,
          ),
          const SizedBox(height: 30),
          _ExperienceItem(
            company: 'Previous Professional Tenure',
            role: 'Cross-Platform Developer',
            period: '2020 - 2021',
            description:
                'Built scalable retail and fintech applications. Mastered multi-environment setups and CI/CD pipelines for Flutter.',
            color: AppColors.warmTeal,
            isVisible: isVisible,
            delay: 300,
          ),
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final String company;
  final String role;
  final String period;
  final String description;
  final Color color;
  final bool isVisible;
  final int delay;

  const _ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    required this.color,
    required this.isVisible,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return GlassContainer(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 60,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            company,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontSize: isMobile ? 20 : 24),
                          ),
                          Text(
                            role,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile) ...[
                      const SizedBox(width: 40),
                      Text(
                        period,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textDim,
                        ),
                      ),
                    ],
                  ],
                ),
                if (isMobile) ...[
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      period,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.textDim),
                    ),
                  ),
                ],
              ],
            ),
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(delay: delay.ms)
        .slideY(begin: 0.1);
  }
}
