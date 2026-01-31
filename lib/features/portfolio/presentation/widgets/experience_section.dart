import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_portfolio/features/portfolio/data/repositories/portfolio_repository.dart';
import 'package:new_portfolio/features/portfolio/domain/models/portfolio_models.dart';
import 'package:new_portfolio/shared/widgets/app_image.dart';
import 'package:new_portfolio/shared/widgets/glass_container.dart';
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

    final experiences = PortfolioRepository.data.experiences;

    return Container(
      // height: size.height,
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
          ...experiences.asMap().entries.map((entry) {
            final index = entry.key;
            final exp = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: _ExperienceItem(
                experience: exp,
                isVisible: isVisible,
                delay: 100 + (index * 200),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final ExperienceData experience;
  final bool isVisible;
  final int delay;

  const _ExperienceItem({
    required this.experience,
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
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: experience.color.withValues(alpha: 0.3),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: AppImage(
                          path: experience.companyLogo,
                          fit: BoxFit.cover,
                          errorWidget: Center(
                            child: Icon(
                              Icons.business_rounded,
                              color: experience.color.withValues(alpha: 0.5),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experience.company,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontSize: isMobile ? 20 : 24),
                          ),
                          Text(
                            experience.role,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: experience.color,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            experience.description,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 20),
                          ...experience.achievements.map(
                            (achievement) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: experience.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      achievement,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColors.textDim,
                                            height: 1.5,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile) ...[
                      const SizedBox(width: 40),
                      Text(
                        experience.period,
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
                      experience.period,
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
