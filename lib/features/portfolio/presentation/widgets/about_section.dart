import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:new_portfolio/features/portfolio/presentation/shared/widgets/glass_container.dart';
import '../../../../core/theme/app_colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final padding = isMobile ? 24.0 : 100.0;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ABOUT ME',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.accent,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slideX(begin: -0.1),
          const SizedBox(height: 50),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: isMobile ? 0 : 3,
                child: GlassContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Passionate Flutter developer with a focus on creating premium, user-centric experiences. With over 3 years of professional experience, I have developed a deep understanding of mobile architecture, performance optimization, and clean code principles.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                height: 1.6,
                                color: AppColors.textPrimary,
                              ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'I believe that great software is more than just code; it\'s about crafting intuitive interactions and beautiful interfaces that solve real-world problems. My journey in tech is driven by continuous learning and a desire to build tools that empower users.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                height: 1.6,
                                color: AppColors.textSecondary,
                              ),
                        ),
                        const SizedBox(height: 32),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _InfoTag(label: 'Based in Mandalay, MM'),
                            _InfoTag(
                              label: 'Full-time / Part-time / Freelance',
                            ),
                            _InfoTag(label: 'Available for Projects'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
              ),
              if (isMobile) const SizedBox(height: 40),
              if (!isMobile) ...[
                const SizedBox(width: 80),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _StatCard(number: '3+', label: 'Years Experience'),
                      const SizedBox(height: 20),
                      _StatCard(number: '7+', label: 'Projects Completed'),
                      const SizedBox(height: 20),
                      _StatCard(number: '5+', label: 'Happy Clients'),
                    ],
                  ),
                ),
              ],
            ],
          ),

          if (isMobile)
            Column(
              children: [
                _StatCard(number: '3+', label: 'Years Experience'),
                const SizedBox(height: 20),
                _StatCard(number: '7+', label: 'Projects Completed'),
                const SizedBox(height: 20),
                _StatCard(number: '5+', label: 'Happy Clients'),
              ],
            ),
        ],
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final String label;
  const _InfoTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.accent,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String label;

  const _StatCard({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: AppColors.textDim, fontSize: 14),
          ),
        ],
      ),
    ).animate().fadeIn().scale(delay: 400.ms);
  }
}
