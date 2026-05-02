import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_portfolio/features/portfolio/data/repositories/portfolio_repository.dart';
import '../../../../core/theme/app_colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final padding = isMobile ? 24.0 : 96.0;

    final aboutData = PortfolioRepository.data.about;

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
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: isMobile ? 0 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aboutData.title,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textPrimary,
                        fontSize: isMobile ? 32 : 48,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        letterSpacing: -0.96,
                      ),
                    ).animate().fadeIn().slideX(begin: -0.1),

                    const SizedBox(height: 24),

                    Text(
                      aboutData.bio1,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ).animate().fadeIn(delay: 200.ms),

                    const SizedBox(height: 16),

                    Text(
                      aboutData.bio2,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ).animate().fadeIn(delay: 300.ms),

                    const SizedBox(height: 32),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: aboutData.tags
                          .map((tag) => _TechChip(label: tag))
                          .toList(),
                    ).animate().fadeIn(delay: 400.ms),
                  ],
                ),
              ),

              SizedBox(width: isMobile ? 0 : 48, height: isMobile ? 48 : 0),

              Expanded(
                flex: isMobile ? 0 : 1,
                child: const _CodeSnippetPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _CodeSnippetPanel extends StatefulWidget {
  const _CodeSnippetPanel();

  @override
  State<_CodeSnippetPanel> createState() => _CodeSnippetPanelState();
}

class _CodeSnippetPanelState extends State<_CodeSnippetPanel> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E).withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: _isHovered ? 0.1 : 0.05),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isHovered ? 1.0 : 0.5,
                child: Icon(
                  Icons.content_copy,
                  size: 16,
                  color: _isHovered
                      ? AppColors.primary
                      : AppColors.outlineVariant,
                ),
              ),
            ),
            SelectableText.rich(
              TextSpan(
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textSecondary,
                ),
                children: [
                  TextSpan(
                    text: 'class ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(
                    text: 'AppArchitecture ',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  TextSpan(
                    text: 'extends ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(
                    text: 'StatelessWidget ',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  const TextSpan(text: '{\n'),
                  const TextSpan(text: '  @override\n'),
                  const TextSpan(text: '  Widget '),
                  TextSpan(
                    text: 'build',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(text: '(BuildContext context) {\n'),
                  const TextSpan(text: '    return '),
                  const TextSpan(
                    text: 'MultiBlocProvider',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  const TextSpan(text: '(\n'),
                  const TextSpan(text: '      providers: [\n'),
                  const TextSpan(text: '        BlocProvider(\n'),
                  const TextSpan(text: '          create: (_) => '),
                  const TextSpan(
                    text: 'ThemeCubit',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  const TextSpan(text: '()),\n'),
                  const TextSpan(text: '        BlocProvider(\n'),
                  const TextSpan(text: '          create: (_) => '),
                  const TextSpan(
                    text: 'AuthBloc',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  const TextSpan(text: '()),\n'),
                  const TextSpan(text: '      ],\n'),
                  const TextSpan(text: '      child: '),
                  const TextSpan(
                    text: 'MaterialApp',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  const TextSpan(text: '.router(\n'),
                  const TextSpan(text: '        themeMode: ThemeMode.dark,\n'),
                  const TextSpan(text: '        routerConfig: appRouter,\n'),
                  const TextSpan(text: '      ),\n'),
                  const TextSpan(text: '    );\n'),
                  const TextSpan(text: '  }\n'),
                  const TextSpan(text: '}'),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
    );
  }
}
