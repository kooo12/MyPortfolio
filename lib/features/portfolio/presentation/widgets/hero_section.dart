import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_portfolio/features/portfolio/data/repositories/portfolio_repository.dart';
import 'package:new_portfolio/features/portfolio/presentation/providers/scroll_provider.dart';
import 'package:new_portfolio/shared/widgets/app_image.dart';
import '../../../../core/theme/app_colors.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final padding = isMobile ? 24.0 : 96.0;

    final heroData = PortfolioRepository.data.hero;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 96),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.center,
            children: [
              // Text content
              Flexible(
                flex: isMobile ? 0 : 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    if (isMobile) ...[
                      const _ProfilePhoto(),
                      const SizedBox(height: 40),
                    ],
                    // Name label
                    Text(
                      heroData.title,
                      textAlign:
                          isMobile ? TextAlign.center : TextAlign.start,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),

                    const SizedBox(height: 24),

                    // Main title with "Cross-Platform" in muted color
                    _buildTitle(context, isMobile)
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 800.ms)
                        .slideY(begin: 0.1),

                    const SizedBox(height: 24),

                    // Description
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        heroData.description,
                        textAlign:
                            isMobile ? TextAlign.center : TextAlign.start,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 800.ms),

                    const SizedBox(height: 40),

                    // CTA Buttons
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      alignment: isMobile
                          ? WrapAlignment.center
                          : WrapAlignment.start,
                      children: [
                        _CTAButton(
                          label: 'View Selected Works',
                          filled: true,
                          onTap: () => ref
                              .read(scrollProvider.notifier)
                              .scrollToSection(2),
                        ),
                        _CTAButton(
                          label: "Let's Connect",
                          filled: false,
                          onTap: () => ref
                              .read(scrollProvider.notifier)
                              .scrollToSection(4),
                        ),
                      ],
                    ).animate().fadeIn(delay: 600.ms, duration: 800.ms),
                  ],
                ),
              ),

              if (!isMobile)
                const Expanded(child: Center(child: _ProfilePhoto())),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isMobile) {
    final titleSize = isMobile ? 40.0 : 72.0;
    return RichText(
      textAlign: isMobile ? TextAlign.center : TextAlign.start,
      text: TextSpan(
        style: GoogleFonts.spaceGrotesk(
          fontSize: titleSize,
          fontWeight: FontWeight.w700,
          height: 1.1,
          letterSpacing: -2.88,
          color: AppColors.textPrimary,
        ),
        children: [
          const TextSpan(text: 'Engineering Fluid\n'),
          TextSpan(
            text: 'Cross-Platform',
            style: TextStyle(
              color: AppColors.surfaceContainerHighest,
            ),
          ),
          const TextSpan(text: '\nExperiences'),
        ],
      ),
    );
  }
}

class _ProfilePhoto extends StatefulWidget {
  const _ProfilePhoto();

  @override
  State<_ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<_ProfilePhoto> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 400,
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          // border: Border.all(
          //   color: AppColors.surfaceContainerHighest,
          //   width: 2,
          // ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              // Color image (always visible underneath)
              AppImage(
                path: PortfolioRepository.data.hero.profileImg,
                width: 400,
                height: 450,
                fit: BoxFit.cover,
              ),
              // Grayscale overlay that fades out on hover
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  opacity: _isHovered ? 0.0 : 1.0,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0, 0, 0, 0.8, 0,
                    ]),
                    child: AppImage(
                      path: PortfolioRepository.data.hero.profileImg,
                      width: 400,
                      height: 450,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 1.seconds)
          .scale(begin: const Offset(0.95, 0.95)),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _CTAButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          decoration: BoxDecoration(
            color: widget.filled ? AppColors.primaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: widget.filled
                ? null
                : Border.all(color: AppColors.outlineVariant),
            boxShadow: widget.filled && _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryContainer.withValues(alpha: 0.3),
                      blurRadius: 15,
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.spaceGrotesk(
              color: widget.filled ? Colors.white : AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
