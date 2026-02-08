import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:new_portfolio/shared/widgets/mouse_tilt_wrapper.dart';
import 'dart:async';
import '../../domain/models/portfolio_models.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/repositories/portfolio_repository.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int? _hoveredIndex;
  int? _expandedIndex;
  late ScrollController _scrollController;
  bool _showLeftArrow = false;
  bool _showRightArrow = true;
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateArrows);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateArrows());
  }

  void _updateArrows() {
    if (!_scrollController.hasClients) return;
    setState(() {
      _showLeftArrow = _scrollController.offset > 0;
      _showRightArrow =
          _scrollController.offset < _scrollController.position.maxScrollExtent;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _startScrolling(bool right) {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!_scrollController.hasClients) return;

      double delta = right ? 25.0 : -25.0;
      double newOffset = _scrollController.offset + delta;

      if (newOffset < 0) {
        newOffset = 0;
        timer.cancel();
      } else if (newOffset > _scrollController.position.maxScrollExtent) {
        newOffset = _scrollController.position.maxScrollExtent;
        timer.cancel();
      }

      _scrollController.jumpTo(newOffset);
    });
  }

  void _stopScrolling() {
    _scrollTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    final skills = PortfolioRepository.data.skills;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 0,
        vertical: 50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isMobile)
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: List.generate(skills.length, (index) {
                final cardWidth = (size.width - 60) / 2;
                return SizedBox(
                  width: cardWidth.clamp(140.0, 200.0),
                  child: _buildSkillCard(skills[index], index, isMobile: true),
                );
              }),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = 280;
                double gap = 20;
                double totalCardWidth = cardWidth + gap;

                double availableWidth = constraints.maxWidth - 160;
                int cardsToShow = (availableWidth / totalCardWidth).floor();
                if (cardsToShow < 1) cardsToShow = 1;

                double containerWidth = (cardsToShow * totalCardWidth) - gap;

                return SizedBox(
                  height: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildArrow(
                        icon: Icons.arrow_back_ios_rounded,
                        visible: _showLeftArrow,
                        onHover: (hovering) {
                          if (hovering) {
                            _startScrolling(false);
                          } else {
                            _stopScrolling();
                          }
                        },
                      ),

                      const SizedBox(width: 20),

                      SizedBox(
                        width: containerWidth,
                        child: ListView.separated(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          itemCount: skills.length,
                          separatorBuilder: (_, _) => SizedBox(width: gap),
                          itemBuilder: (context, index) {
                            return _buildSkillCard(
                              skills[index],
                              index,
                              isMobile: false,
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 20),

                      _buildArrow(
                        icon: Icons.arrow_forward_ios_rounded,
                        visible: _showRightArrow,
                        onHover: (hovering) {
                          if (hovering) {
                            _startScrolling(true);
                          } else {
                            _stopScrolling();
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildArrow({
    required IconData icon,
    required bool visible,
    required Function(bool) onHover,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceLight.withValues(alpha: 0.5),
            border: Border.all(color: AppColors.surfaceLight),
          ),
          child: Icon(icon, color: AppColors.accent, size: 20),
        ),
      ),
    );
  }

  Widget _buildSkillCard(SkillData skill, int index, {required bool isMobile}) {
    bool isHovered = _hoveredIndex == index;
    bool isExpanded = _expandedIndex == index;

    bool showDescription = isHovered || isExpanded;

    double width = isMobile ? double.infinity : 280;
    double collapsedHeight = isMobile ? 240 : 220;
    double expandedHeight = isMobile ? 350 : 320;

    Color baseColor = showDescription
        ? AppColors.surfaceLight
        : AppColors.surface;
    Color accentColor = AppColors.accent;

    Widget cardContent = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      width: width,
      height: showDescription ? expandedHeight : collapsedHeight,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: showDescription
              ? accentColor.withValues(alpha: 0.5)
              : AppColors.surfaceLight.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: showDescription
            ? [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textDim,
                size: 16,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(
                physics: showDescription
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showDescription) const SizedBox(height: 20),
                    AnimatedScale(
                      scale: showDescription ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: isMobile ? 60 : 80,
                        height: isMobile ? 60 : 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.glassGradient,
                        ),
                        child: Center(
                          child: Text(
                            skill.name.substring(0, 1),
                            style: TextStyle(
                              fontSize: isMobile ? 24 : 32,
                              fontWeight: FontWeight.bold,
                              color: showDescription
                                  ? accentColor
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 20 : 15),

                    Text(
                      skill.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      skill.role.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        color: AppColors.textDim,
                      ),
                    ),

                    if (showDescription) ...[
                      const SizedBox(height: 10),
                      const Divider(
                        color: AppColors.textDim,
                        indent: 40,
                        endIndent: 40,
                        thickness: 0.5,
                      ),
                      const SizedBox(height: 10),
                      Text(
                            skill.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.1, curve: Curves.easeOutQuart),
                    ] else ...[
                      SizedBox(height: isMobile ? 20 : 10),
                      Text(
                        skill.level,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: showDescription
                              ? accentColor
                              : AppColors.textDim,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          if (showDescription)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
              ).animate().scaleX(begin: 0, alignment: Alignment.center),
            ),
        ],
      ),
    );

    Widget card = isMobile
        ? GestureDetector(
            onTap: () {
              setState(() {
                if (_expandedIndex == index) {
                  _expandedIndex = null;
                } else {
                  _expandedIndex = index;
                }
              });
            },
            child: cardContent,
          )
        : MouseTiltWrapper(
            onEnter: (_) => setState(() => _hoveredIndex = index),
            onExit: (_) => setState(() => _hoveredIndex = null),
            child: RepaintBoundary(child: cardContent),
          );

    return card.animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1);
  }
}
