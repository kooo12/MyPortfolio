import 'package:flutter/material.dart';
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

class PortfolioView extends ConsumerWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollState = ref.watch(scrollProvider);
    final scrollController = scrollState.controller;
    final keys = scrollState.sectionKeys;

    return Scaffold(
      body: ResponsiveBreakpoints.builder(
        child: Stack(
          children: [
            const AnimatedBackground(),

            CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: RepaintBoundary(child: HeroSection(key: keys[0])),
                ),
                SliverToBoxAdapter(
                  child: RepaintBoundary(child: AboutSection(key: keys[1])),
                ),
                ProjectsSection(key: keys[2]),
                SliverToBoxAdapter(
                  child: RepaintBoundary(child: SkillsSection(key: keys[3])),
                ),
                SliverToBoxAdapter(
                  child: RepaintBoundary(child: ExperienceSection()),
                ),
                SliverToBoxAdapter(
                  child: RepaintBoundary(child: ContactSection(key: keys[4])),
                ),
                const SliverToBoxAdapter(child: FooterSection()),
              ],
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
