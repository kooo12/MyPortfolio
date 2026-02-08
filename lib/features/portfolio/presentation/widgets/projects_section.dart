import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/mouse_tilt_wrapper.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/app_image.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../domain/models/portfolio_models.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    final projects = PortfolioRepository.data.projects;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 100,
        vertical: 50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FEATURED PROJECTS',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.accent,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 3;
              double childAspectRatio = 0.85;

              if (constraints.maxWidth < 700) {
                crossAxisCount = 1;
                childAspectRatio = 1.4;
              } else if (constraints.maxWidth < 1100) {
                crossAxisCount = 2;
                childAspectRatio = 0.9;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return ProjectCard(project: project)
                      .animate()
                      .fadeIn(delay: (index * 200).ms)
                      .scale(begin: const Offset(0.9, 0.9));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectData project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  void _onEnter(_) => setState(() => _isHovered = true);
  void _onExit(_) => setState(() => _isHovered = false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1100;
    final isMobile = size.width < 700;

    return MouseTiltWrapper(
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: () {
          context.push('/project-details', extra: widget.project);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.project.color.withValues(alpha: 0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: GlassContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isMobile ? 4 : 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.project.color.withValues(alpha: 0.1),
                          widget.project.color.withValues(alpha: 0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: AnimatedScale(
                            scale: _isHovered ? 1.1 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: Hero(
                              tag: 'project_image_${widget.project.title}_0',
                              child: AppImage(
                                path: widget.project.image,
                                fit: BoxFit.contain,
                                errorWidget: Center(
                                  child: Icon(
                                    Icons.apps_rounded,
                                    size: 40,
                                    color: widget.project.color.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background.withValues(
                                alpha: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: widget.project.color.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            child: Text(
                              widget.project.category,
                              style: TextStyle(
                                fontSize: 10,
                                color: widget.project.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (_isHovered)
                          const Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.arrow_outward,
                                color: AppColors.textPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _isHovered
                                    ? AppColors.accent
                                    : AppColors.textPrimary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.project.description,
                          maxLines: isDesktop ? 3 : 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                        if (isDesktop) ...[
                          const SizedBox(height: 12),
                          ...widget.project.coreFeatures
                              .take(3)
                              .map(
                                (feature) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 10,
                                        color: widget.project.color,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppColors.textDim,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.project.techStack
                              .take(isMobile ? 5 : 5)
                              .map((tech) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceLight.withValues(
                                      alpha: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: AppColors.surfaceLight,
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.textDim,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (widget.project.playStoreUrl != null) ...[
                                  const FaIcon(
                                    FontAwesomeIcons.googlePlay,
                                    size: 14,
                                    color: AppColors.textDim,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                if (widget.project.appStoreUrl != null)
                                  const FaIcon(
                                    FontAwesomeIcons.apple,
                                    size: 14,
                                    color: AppColors.textDim,
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                if (widget.project.githubUrl != null) ...[
                                  const _ProjectLink(
                                    icon: FontAwesomeIcons.github,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                if (widget.project.webUrl != null)
                                  const _ProjectLink(
                                    icon: FontAwesomeIcons.globe,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectLink extends StatelessWidget {
  final IconData icon;

  const _ProjectLink({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: FaIcon(icon, size: 14, color: AppColors.textDim),
    );
  }
}
