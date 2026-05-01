import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_portfolio/features/portfolio/data/repositories/portfolio_repository.dart';
import '../../../../core/theme/app_colors.dart';

class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    final padding = isMobile ? 24.0 : 96.0;
    final experiences = PortfolioRepository.data.experiences;

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
                'Professional Trajectory',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textPrimary,
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ).animate().fadeIn(),
              const SizedBox(height: 8),
              Text(
                'Architectural precision honed through years of dedicated cross-platform engineering.',
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary, fontSize: 16, height: 1.6,
                ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 48),
              ...experiences.asMap().entries.map((entry) {
                final exp = entry.value;
                return Container(
                  padding: const EdgeInsets.only(top: 24),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: AppColors.surfaceContainerHighest)),
                  ),
                  child: isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(exp.role, style: GoogleFonts.spaceGrotesk(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(exp.company, style: GoogleFonts.spaceGrotesk(color: AppColors.primary, fontSize: 16)),
                            Text(exp.period, style: GoogleFonts.inter(color: AppColors.textDim, fontSize: 14, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 16),
                            Text(exp.description, style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 16, height: 1.6)),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 320,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(exp.role, style: GoogleFonts.spaceGrotesk(color: AppColors.textPrimary, fontSize: 32, fontWeight: FontWeight.w600, height: 1.3)),
                                  const SizedBox(height: 4),
                                  Text(exp.company, style: GoogleFonts.spaceGrotesk(color: AppColors.primary, fontSize: 18)),
                                  Text(exp.period, style: GoogleFonts.inter(color: AppColors.textDim, fontSize: 14, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 48),
                            Expanded(child: Text(exp.description, style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 16, height: 1.6))),
                          ],
                        ),
                ).animate().fadeIn(delay: (200 + entry.key * 150).ms).slideY(begin: 0.05);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
