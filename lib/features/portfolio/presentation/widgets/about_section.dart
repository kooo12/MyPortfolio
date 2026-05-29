import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          child: Column(
            children: [
              Flex(
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
                        ).animate().fadeIn(delay: 500.ms),
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
              if (aboutData.bio3Title != null) ...[
                const SizedBox(height: 32),
                Text(
                  aboutData.bio3Title!,
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.4,
                  ),
                ).animate().fadeIn(delay: 350.ms),
                const SizedBox(height: 12),
              ] else ...[
                const SizedBox(height: 16),
              ],

              Text(
                aboutData.bio3,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.6,
                ),
              ).animate().fadeIn(delay: 400.ms),
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
  bool _copied = false;

  static const String _codeSnippet =
      '''class AppArchitecture extends ConsumerWidget {
  const AppArchitecture({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeStyle = ref.watch(themeNotifierProvider);
    final themeData = AppTheme.getTheme(themeStyle);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      theme: themeData,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Perfect place for global initializations like custom overlays, 
        // responsive text scaling, or universal design wrappers.
        return child ?? const SizedBox.shrink();
      },
    );
  }
}''';

  void _copyToClipboard() {
    Clipboard.setData(const ClipboardData(text: _codeSnippet));
    setState(() {
      _copied = true;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.greenAccent,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              'Code copied to clipboard!',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        width: 320,
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _copied = false;
        });
      }
    });
  }

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
                    text: 'ConsumerWidget ',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  const TextSpan(text: '{\n'),
                  TextSpan(
                    text: '  const ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(
                    text: 'AppArchitecture',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  const TextSpan(text: '({'),
                  TextSpan(
                    text: 'super',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(text: '.key});\n\n'),
                  const TextSpan(
                    text: '  @override\n',
                    style: TextStyle(color: Color(0xFFC586C0)),
                  ),
                  const TextSpan(text: '  Widget '),
                  const TextSpan(
                    text: 'build',
                    style: TextStyle(color: Color(0xFFDCDCAA)),
                  ),
                  const TextSpan(
                    text: '(BuildContext context, WidgetRef ref) {\n',
                  ),
                  TextSpan(
                    text: '    final ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(
                    text: 'themeStyle = ref.watch(themeNotifierProvider);\n',
                  ),
                  TextSpan(
                    text: '    final ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(
                    text: 'themeData = AppTheme.getTheme(themeStyle);\n',
                  ),
                  TextSpan(
                    text: '    final ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(
                    text: 'router = ref.watch(appRouterProvider);\n\n',
                  ),
                  TextSpan(
                    text: '    return ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(
                    text: 'MaterialApp',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  const TextSpan(text: '.router(\n'),
                  const TextSpan(text: '      theme: themeData,\n'),
                  const TextSpan(text: '      routerConfig: router,\n'),
                  const TextSpan(text: '      debugShowCheckedModeBanner: '),
                  TextSpan(
                    text: 'false',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(text: ',\n'),
                  const TextSpan(text: '      builder: (context, child) {\n'),
                  // const TextSpan(
                  //   text: '        // Perfect place for global initializations like custom overlays,\n',
                  //   style: TextStyle(color: Color(0xFF6A9955)),
                  // ),
                  // const TextSpan(
                  //   text: '        // responsive text scaling, or universal design wrappers.\n',
                  //   style: TextStyle(color: Color(0xFF6A9955)),
                  // ),
                  TextSpan(
                    text: '        return ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(text: 'child ?? '),
                  TextSpan(
                    text: 'const ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  const TextSpan(
                    text: 'SizedBox',
                    style: TextStyle(color: Color(0xFF4EC9B0)),
                  ),
                  const TextSpan(text: '.shrink();\n'),
                  const TextSpan(text: '      },\n'),
                  const TextSpan(text: '    );\n'),
                  const TextSpan(text: '  }\n'),
                  const TextSpan(text: '}'),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Tooltip(
                message: _copied ? 'Copied!' : 'Copy code',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: _copyToClipboard,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          _copied
                              ? Icons.check_circle_outline_rounded
                              : Icons.content_copy_rounded,
                          key: ValueKey<bool>(_copied),
                          size: 18,
                          color: _copied
                              ? Colors.greenAccent
                              : (_isHovered
                                    ? AppColors.primary
                                    : AppColors.outlineVariant),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
    );
  }
}
