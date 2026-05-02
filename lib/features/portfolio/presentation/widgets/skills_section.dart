import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../../../core/theme/app_colors.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    final padding = isMobile ? 24.0 : 96.0;
    final skills = PortfolioRepository.data.skills;

    final coreEngine = <String>[];
    final stateArch = <String>[];
    final ecosystem = <String>[];

    for (final skill in skills) {
      final name = skill.name.toLowerCase();
      if (name.contains('flutter') || name.contains('dart')) {
        coreEngine.add(skill.name);
      } else if (name.contains('clean') ||
          name.contains('bloc') ||
          name.contains('riverpod') ||
          name.contains('getx') ||
          name.contains('rest api')) {
        stateArch.add(skill.name);
      } else {
        ecosystem.add(skill.name);
      }
    }

    if (coreEngine.length < 3) {
      coreEngine.addAll([
        'Custom Painters',
        'Animations API',
        'Method Channels',
      ]);
    }
    if (stateArch.length < 3) {
      stateArch.addAll([
        'BLoC / Cubit',
        'Riverpod',
        'GetX',
        'Clean Architecture',
        'Dependency Injection',
      ]);
    }
    if (ecosystem.length < 3) {
      ecosystem.addAll([
        'Firebase',
        'REST APIs',
        'Codemagic CI/CD',
        'Supabase',
        'Sentry',
      ]);
    }

    final coreSet = coreEngine.toSet().toList();
    final stateSet = stateArch.toSet().toList();
    final ecoSet = ecosystem.toSet().toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 96),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.surfaceContainerHighest, width: 1),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Architectural Precision.',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textPrimary,
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  letterSpacing: -0.96,
                ),
              ).animate().fadeIn().slideX(begin: -0.05),

              const SizedBox(height: 16),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Text(
                  'A track record of engineering scalable, high-performance Flutter applications. Specializing in declarative UI paradigms, state management mastery, and native-bridge integrations to deliver seamless cross-platform experiences.',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ).animate().fadeIn(delay: 100.ms),

              const SizedBox(height: 48),
              Row(
                children: [
                  Icon(
                    Icons.settings_suggest,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Technical Arsenal',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 24),

              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 700) {
                    return Column(
                      children: [
                        _SkillCategory(title: 'CORE ENGINE', items: coreSet),
                        const SizedBox(height: 24),
                        _SkillCategory(
                          title: 'STATE & ARCHITECTURE',
                          items: stateSet,
                        ),
                        const SizedBox(height: 24),
                        _SkillCategory(
                          title: 'ECOSYSTEM & DEVOPS',
                          items: ecoSet,
                        ),
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _SkillCategory(
                          title: 'CORE ENGINE',
                          items: coreSet,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _SkillCategory(
                          title: 'STATE & ARCHITECTURE',
                          items: stateSet,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _SkillCategory(
                          title: 'ECOSYSTEM & DEVOPS',
                          items: ecoSet,
                        ),
                      ),
                    ],
                  );
                },
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillCategory extends StatelessWidget {
  final String title;
  final List<String> items;

  const _SkillCategory({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) => _SkillPill(label: item)).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillPill extends StatelessWidget {
  final String label;

  const _SkillPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
