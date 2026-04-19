import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_portfolio/shared/widgets/mouse_tilt_wrapper.dart';
import '../../domain/models/portfolio_models.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../../../shared/widgets/glass_container.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    final skills = PortfolioRepository.data.skills;
    final double pixelsPerCard = isMobile ? 400.0 : 600.0;

    return SliverPersistentHeader(
      delegate: _MagicStackSliverDelegate(
        skills: skills,
        screenHeight: size.height,
        pixelsPerCard: pixelsPerCard,
        isMobile: isMobile,
      ),
    );
  }
}

class _MagicStackSliverDelegate extends SliverPersistentHeaderDelegate {
  final List<SkillData> skills;
  final double screenHeight;
  final double pixelsPerCard;
  final bool isMobile;

  _MagicStackSliverDelegate({
    required this.skills,
    required this.screenHeight,
    required this.pixelsPerCard,
    required this.isMobile,
  });

  @override
  double get minExtent => screenHeight;

  @override
  double get maxExtent => screenHeight + (skills.length * pixelsPerCard);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double currentIndex = shrinkOffset / pixelsPerCard;
    int activeCardIndex = currentIndex.round().clamp(0, skills.length - 1);

    return SizedBox(
      height: screenHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + (isMobile ? 50 : 50),
            left: 0,
            right: 0,
            child: Opacity(
              opacity:
                  (1.0 -
                          (shrinkOffset - pixelsPerCard * (skills.length - 1)) /
                              (pixelsPerCard))
                      .clamp(0.0, 1.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'MY ARSENAL',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        letterSpacing: 4,
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.2),
                    const SizedBox(height: 8),
                    Text(
                      'Skills & Technologies',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: screenHeight * (isMobile ? 0.5 : 0.25),
            child: Opacity(
              opacity: (currentIndex - (skills.length - 1)).clamp(0.0, 1.0),
              child: Column(
                children: [
                  Icon(
                        Icons.keyboard_double_arrow_down_rounded,
                        color: AppColors.accent,
                        size: 40,
                      )
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .moveY(
                        begin: -10,
                        end: 10,
                        duration: 1000.ms,
                        curve: Curves.easeInOut,
                      ),
                  const SizedBox(height: 10),
                  const Text(
                    "EXPLORE PROJECTS",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned.fill(
            child: MagicSparklesLayer(
              activeIndex: activeCardIndex,
              skills: skills,
              isMobile: isMobile,
            ),
          ),

          ...List.generate(skills.length, (i) {
            int index = skills.length - 1 - i;
            SkillData skill = skills[index];

            double progress = index - currentIndex;

            double opacity = 1.0;
            double scale = 1.0;
            double yOffset = 0.0;
            double xOffset = 0.0;
            double rotateAngle = 0.0;

            if (progress > 0) {
              if (progress > 3) {
                opacity = 0.0;
              } else {
                opacity = (1.0 - (progress * 0.2)).clamp(0.0, 1.0);
                scale = 1.0 - (progress * 0.05);
                yOffset = progress * (isMobile ? 30.0 : 40.0);
              }
            } else if (progress <= 0) {
              final t = progress.abs().clamp(0.0, 1.0);

              opacity = (1.0 + progress * 2).clamp(0.0, 1.0);
              scale = 1.0 + (t * 0.05);
              final direction = (index.isEven) ? 1.0 : -1.0;
              rotateAngle = direction * t * (math.pi / 5);
              xOffset = direction * t * (isMobile ? 180.0 : 260.0);
              yOffset = t * (isMobile ? -60.0 : -80.0);
            }

            if (opacity < 0.01) return const SizedBox.shrink();

            final bool isActive = progress.abs() < 0.5;

            return Align(
              alignment: Alignment.center,
              child: RepaintBoundary(
                child: Transform.translate(
                  offset: Offset(xOffset, yOffset + (isMobile ? 20 : 90)),
                  child: Transform.rotate(
                    angle: rotateAngle,
                    child: Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity,
                        child: SkillCardWidget(
                          skill: skill,
                          isMobile: isMobile,
                          isActive: isActive,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _MagicStackSliverDelegate oldDelegate) {
    return oldDelegate.screenHeight != screenHeight ||
        oldDelegate.pixelsPerCard != pixelsPerCard ||
        oldDelegate.isMobile != isMobile;
  }
}

class MagicSparklesLayer extends StatefulWidget {
  final int activeIndex;
  final List<SkillData> skills;
  final bool isMobile;

  const MagicSparklesLayer({
    super.key,
    required this.activeIndex,
    required this.skills,
    required this.isMobile,
  });

  @override
  State<MagicSparklesLayer> createState() => _MagicSparklesLayerState();
}

class _MagicSparklesLayerState extends State<MagicSparklesLayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _bobController;
  late Animation<double> _bobAnimation;

  late List<SkillIconData> _iconData;

  @override
  void initState() {
    super.initState();
    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _bobAnimation = Tween<double>(
      begin: -6.0,
      end: 6.0,
    ).animate(CurvedAnimation(parent: _bobController, curve: Curves.easeInOut));
    _cacheIcons();
  }

  @override
  void didUpdateWidget(covariant MagicSparklesLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.skills != widget.skills) {
      _cacheIcons();
    }
  }

  void _cacheIcons() {
    _iconData = widget.skills.map((s) => getSkillIconAndColor(s.name)).toList();
  }

  @override
  void dispose() {
    _bobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int count = widget.skills.length;
    final double orbitRadius = widget.isMobile ? 185.0 : 270.0;
    final double iconSize = widget.isMobile ? 16.0 : 20.0;

    return AnimatedBuilder(
      animation: _bobAnimation,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: List.generate(count, (i) {
            final double angle = (2 * math.pi / count) * i - (math.pi / 2);
            final double dx = orbitRadius * math.cos(angle);
            final double phase = (i / count) * 2 * math.pi;
            final double bobY =
                math.sin(_bobController.value * 2 * math.pi + phase) * 6.0;
            final double dy =
                orbitRadius * math.sin(angle) +
                (widget.isMobile ? 20 : 90) +
                bobY;

            final skillIcon = _iconData[i];
            final bool isActive = i == widget.activeIndex;
            final Color iconColor = isActive
                ? skillIcon.color
                : skillIcon.color.withValues(alpha: 0.35);
            final double size = isActive
                ? (widget.isMobile ? 24.0 : 28.0)
                : iconSize;

            Widget icon = FaIcon(skillIcon.icon, size: size, color: iconColor);

            if (isActive) {
              icon = Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withValues(alpha: 0.55),
                      blurRadius: 18,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: icon,
              );
            }

            return Transform.translate(offset: Offset(dx, dy), child: icon);
          }),
        );
      },
    );
  }
}

class SkillCardWidget extends StatefulWidget {
  final SkillData skill;
  final bool isMobile;
  final bool isActive;

  const SkillCardWidget({
    super.key,
    required this.skill,
    required this.isMobile,
    this.isActive = true,
  });

  @override
  State<SkillCardWidget> createState() => _SkillCardWidgetState();
}

class _SkillCardWidgetState extends State<SkillCardWidget> {
  bool _isHovered = false;
  late SkillIconData _iconData;

  @override
  void initState() {
    super.initState();
    _iconData = getSkillIconAndColor(widget.skill.name);
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = AppColors.accent;
    final double width = widget.isMobile
        ? MediaQuery.of(context).size.width * 0.85
        : 380;
    final double height = widget.isMobile ? 450 : 500;

    if (!widget.isActive) {
      return SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.surface.withValues(alpha: 0.88),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.85),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
        ),
      );
    }

    final iconData = _iconData;
    Widget cardContent = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: !_isHovered
            ? [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.35),
                  blurRadius: 45,
                  spreadRadius: 12,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: AppColors.surfaceLight.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: -5,
                  offset: const Offset(0, -10),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 12),
                ),
              ],
      ),
      child: GlassContainer(
        borderRadius: 24,
        blur: !_isHovered ? 25 : 15,
        color: !_isHovered
            ? AppColors.surface.withValues(alpha: 0.88)
            : AppColors.surface.withValues(alpha: 0.65),
        border: Border.all(
          color: _isHovered
              ? accentColor.withValues(alpha: 0.5)
              : accentColor.withValues(alpha: 0.85),
          width: _isHovered ? 1.5 : 2.0,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: width / 2 - 60,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isHovered ? 0.3 : 0.8,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: iconData.color.withValues(alpha: 0.6),
                        blurRadius: 55,
                        spreadRadius: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedScale(
                    scale: !_isHovered ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface.withValues(alpha: 0.8),
                        border: Border.all(
                          color: iconData.color.withValues(alpha: 0.4),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: iconData.color.withValues(alpha: 0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: FaIcon(
                          iconData.icon,
                          size: 36,
                          color: iconData.color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    widget.skill.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.skill.role.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.skill.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      widget.skill.level,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (!widget.isMobile) {
      return MouseTiltWrapper(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: cardContent,
      );
    }

    return cardContent;
  }
}

class SkillIconData {
  final IconData icon;
  final Color color;
  const SkillIconData(this.icon, this.color);
}

SkillIconData getSkillIconAndColor(String name) {
  final lower = name.toLowerCase();

  if (lower.contains('flutter')) {
    return const SkillIconData(FontAwesomeIcons.flutter, Color(0xFF54C5F8));
  }
  if (lower.contains('dart')) {
    return const SkillIconData(FontAwesomeIcons.code, Color(0xFF0175C2));
  }
  if (lower.contains('firebase')) {
    return const SkillIconData(FontAwesomeIcons.fire, Color(0xFFFFCA28));
  }
  if (lower.contains('react')) {
    return const SkillIconData(FontAwesomeIcons.react, Color(0xFF61DAFB));
  }
  if (lower.contains('node')) {
    return const SkillIconData(FontAwesomeIcons.nodeJs, Color(0xFF339933));
  }
  if (lower.contains('python')) {
    return const SkillIconData(FontAwesomeIcons.python, Color(0xFF3776AB));
  }
  if (lower.contains('java') && !lower.contains('script')) {
    return const SkillIconData(FontAwesomeIcons.java, Color(0xFFED8B00));
  }
  if (lower.contains('javascript') || lower.contains('js')) {
    return const SkillIconData(FontAwesomeIcons.js, Color(0xFFF7DF1E));
  }
  if (lower.contains('swift')) {
    return const SkillIconData(FontAwesomeIcons.swift, Color(0xFFFA7343));
  }
  if (lower.contains('kotlin')) {
    return const SkillIconData(FontAwesomeIcons.korvue, Color(0xFF7F52FF));
  }
  if (lower.contains('html')) {
    return const SkillIconData(FontAwesomeIcons.html5, Color(0xFFE34F26));
  }
  if (lower.contains('css')) {
    return const SkillIconData(FontAwesomeIcons.css3Alt, Color(0xFF1572B6));
  }
  if (lower.contains('git')) {
    return const SkillIconData(FontAwesomeIcons.github, Colors.white);
  }
  if (lower.contains('aws')) {
    return const SkillIconData(FontAwesomeIcons.aws, Color(0xFFFF9900));
  }
  if (lower.contains('docker')) {
    return const SkillIconData(FontAwesomeIcons.docker, Color(0xFF2496ED));
  }
  if (lower.contains('figma')) {
    return const SkillIconData(FontAwesomeIcons.figma, Color(0xFFF24E1E));
  }
  if (lower.contains('vue')) {
    return const SkillIconData(FontAwesomeIcons.vuejs, Color(0xFF4FC08D));
  }
  if (lower.contains('angular')) {
    return const SkillIconData(FontAwesomeIcons.angular, Color(0xFFDD0031));
  }
  if (lower.contains('php')) {
    return const SkillIconData(FontAwesomeIcons.php, Color(0xFF777BB4));
  }
  if (lower.contains('laravel')) {
    return const SkillIconData(FontAwesomeIcons.laravel, Color(0xFFFF2D20));
  }
  if (lower.contains('android')) {
    return const SkillIconData(FontAwesomeIcons.android, Color(0xFF3DDC84));
  }
  if (lower.contains('apple') || lower.contains('ios')) {
    return const SkillIconData(FontAwesomeIcons.apple, Colors.white);
  }
  if (lower.contains('markdown')) {
    return const SkillIconData(FontAwesomeIcons.markdown, Colors.white);
  }

  return const SkillIconData(FontAwesomeIcons.laptopCode, Colors.white);
}
