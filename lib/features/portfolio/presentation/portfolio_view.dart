import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_portfolio/features/portfolio/presentation/providers/scroll_provider.dart';
import 'package:new_portfolio/features/portfolio/presentation/widgets/contact_section.dart';
import 'package:new_portfolio/features/portfolio/presentation/widgets/footer_section.dart';
import 'package:new_portfolio/features/portfolio/presentation/widgets/projects_section.dart';
import 'package:new_portfolio/features/portfolio/presentation/widgets/skills_section.dart';
import 'package:new_portfolio/shared/widgets/animated_background.dart';
import 'package:new_portfolio/shared/widgets/custom_nav_bar.dart';
import 'package:new_portfolio/features/portfolio/presentation/widgets/about_section.dart';
import 'package:new_portfolio/features/portfolio/presentation/widgets/experience_section.dart';
import 'package:new_portfolio/features/portfolio/presentation/widgets/hero_section.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PortfolioView extends ConsumerStatefulWidget {
  const PortfolioView({super.key});

  @override
  ConsumerState<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends ConsumerState<PortfolioView> {
  double? _skillsSectionStart;
  bool _isSnapping = false;

  // Keep in sync with SkillsSection constants
  static const double _ppcDesktop = 600.0;
  static const double _ppcMobile = 400.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _cacheSkillsOffset());
  }

  void _cacheSkillsOffset() {
    if (!mounted) return;
    final key = ref.read(scrollProvider).sectionKeys[3];
    if (key?.currentContext == null) return;
    final renderObject = key!.currentContext!.findRenderObject();
    if (renderObject is RenderSliver) {
      final viewport = key.currentContext!
          .findAncestorRenderObjectOfType<RenderViewportBase>();
      if (viewport != null) {
        final result = viewport.getOffsetToReveal(renderObject, 0.0);
        _skillsSectionStart = result.offset;
      }
    }
  }

  void _onScrollEnd(ScrollController controller) {
    if (_isSnapping || !mounted) return;
    final isMobile = MediaQuery.of(context).size.width < 800;
    final ppc = isMobile ? _ppcMobile : _ppcDesktop;

    _cacheSkillsOffset();

    final start = _skillsSectionStart;
    if (start == null) return;

    final relativeOffset = controller.offset - start;
    if (relativeOffset < 0) return;

    final cardIndex = (relativeOffset / ppc).round();
    final snappedOffset = start + (cardIndex * ppc);

    if ((controller.offset - snappedOffset).abs() > 5) {
      _isSnapping = true;
      controller
          .animateTo(
            snappedOffset.clamp(0.0, controller.position.maxScrollExtent),
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeOutCubic,
          )
          .then((_) => _isSnapping = false);
    }
  }

  bool _onNotification(
    ScrollNotification notification,
    ScrollController controller,
  ) {
    if (notification is ScrollEndNotification) {
      _onScrollEnd(controller);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final scrollState = ref.watch(scrollProvider);
    final scrollController = scrollState.controller;
    final keys = scrollState.sectionKeys;

    return Scaffold(
      body: ResponsiveBreakpoints.builder(
        child: Stack(
          children: [
            const AnimatedBackground(),

            NotificationListener<ScrollNotification>(
              onNotification: (n) => _onNotification(n, scrollController),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: RepaintBoundary(child: HeroSection(key: keys[0])),
                  ),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(child: AboutSection(key: keys[1])),
                  ),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: ExperienceSection(key: keys[2]),
                    ),
                  ),
                  SkillsSection(key: keys[3]),
                  ProjectsSection(key: keys[4]),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(child: ContactSection(key: keys[5])),
                  ),
                  const SliverToBoxAdapter(child: FooterSection()),
                ],
              ),
            ),

            const CustomNavBar(),
          ],
        ),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: 'MOBILE'),
          const Breakpoint(start: 451, end: 800, name: 'TABLET'),
          const Breakpoint(start: 801, end: 1920, name: 'DESKTOP'),
        ],
      ),
    );
  }
}
