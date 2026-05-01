import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_image.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../domain/models/portfolio_models.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    final padding = isMobile ? 24.0 : 96.0;
    final projects = PortfolioRepository.data.projects;

    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: 96),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.surfaceContainerHighest,
              width: 1,
            ),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                // Section Title
                Text(
                  'Selected Works',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    letterSpacing: -0.96,
                  ),
                ).animate().fadeIn().slideY(begin: -0.1),

                const SizedBox(height: 48),

                // Bento Grid
                if (isMobile)
                  _buildMobileGrid(projects, context)
                else
                  _buildDesktopBentoGrid(projects, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopBentoGrid(
    List<ProjectData> projects,
    BuildContext context,
  ) {
    return Column(
      children: [
        // Row 1: Large (2/3) + Small (1/3)
        SizedBox(
          height: 480,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: _BentoProjectCard(
                  project: projects[0],
                  isLarge: true,
                  isHorizontal: false,
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: _BentoProjectCard(
                  project: projects.length > 1 ? projects[1] : projects[0],
                  isLarge: false,
                  isHorizontal: false,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Row 2: Small (1/3) + Large horizontal (2/3)
        SizedBox(
          height: 380,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: _BentoProjectCard(
                  project: projects.length > 2 ? projects[2] : projects[0],
                  isLarge: false,
                  isHorizontal: false,
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: _BentoProjectCard(
                  project: projects.length > 3 ? projects[3] : projects[0],
                  isLarge: true,
                  isHorizontal: true,
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileGrid(List<ProjectData> projects, BuildContext context) {
    return Column(
      children: projects
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _BentoProjectCard(
                project: p,
                isLarge: false,
                isHorizontal: false,
              ).animate().fadeIn().slideY(begin: 0.1),
            ),
          )
          .toList(),
    );
  }
}

class _BentoProjectCard extends StatefulWidget {
  final ProjectData project;
  final bool isLarge;
  final bool isHorizontal;

  const _BentoProjectCard({
    required this.project,
    required this.isLarge,
    required this.isHorizontal,
  });

  @override
  State<_BentoProjectCard> createState() => _BentoProjectCardState();
}

class _BentoProjectCardState extends State<_BentoProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final card = GestureDetector(
      onTap: () {
        context.push('/project-details', extra: widget.project);
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: _isHovered ? 0.1 : 0.05),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryContainer.withValues(alpha: 0.3),
                      blurRadius: 15,
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: widget.isHorizontal
                ? _buildHorizontalLayout()
                : _buildVerticalLayout(),
          ),
        ),
      ),
    );

    return card;
  }

  Widget _buildVerticalLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image section
        Expanded(
          flex: widget.isLarge ? 3 : 2,
          child: _buildImageSection(),
        ),
        // Content section
        Expanded(
          flex: 2,
          child: _buildContentSection(),
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      children: [
        // Image section
        Expanded(child: _buildImageSection()),
        // Content section
        Expanded(child: _buildContentSection()),
      ],
    );
  }

  Widget _buildImageSection() {
    final imageWidget = widget.project.image.isNotEmpty
        ? AppImage(
            path: widget.project.image,
            fit: BoxFit.cover,
            errorWidget: _buildPlaceholder(),
          )
        : _buildPlaceholder();

    return Stack(
      children: [
        // Color image (always underneath)
        Positioned.fill(
          child: AnimatedScale(
            scale: _isHovered ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 700),
            child: imageWidget,
          ),
        ),
        // Grayscale overlay that fades out on hover
        if (widget.project.image.isNotEmpty)
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              opacity: _isHovered ? 0.0 : 1.0,
              child: AnimatedScale(
                scale: _isHovered ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 700),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.matrix(<double>[
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0, 0, 0, 0.8, 0,
                  ]),
                  child: AppImage(
                    path: widget.project.image,
                    fit: BoxFit.cover,
                    errorWidget: _buildPlaceholder(),
                  ),
                ),
              ),
            ),
          ),
        // Blue tint overlay that fades out on hover
        Positioned.fill(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            opacity: _isHovered ? 0.0 : 1.0,
            child: Container(
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Center(
        child: Icon(
          Icons.apps_rounded,
          size: 48,
          color: AppColors.primary.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title row with link icon for large cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.project.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textPrimary,
                    fontSize: widget.isLarge ? 32 : 18,
                    fontWeight: widget.isLarge
                        ? FontWeight.w600
                        : FontWeight.w700,
                    height: 1.3,
                  ),
                ),
              ),
              if (widget.isLarge)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.open_in_new,
                    color: _isHovered
                        ? AppColors.primaryContainer
                        : AppColors.primary,
                    size: 20,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            widget.project.description,
            maxLines: widget.isLarge ? 3 : 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: widget.isLarge ? 16 : 14,
              height: 1.6,
            ),
          ),

          if (widget.isLarge) ...[
            const SizedBox(height: 16),
            // Tech stack chips
            Wrap(
              spacing: 8,
              children: widget.project.techStack
                  .take(4)
                  .map(
                    (tech) => Text(
                      tech,
                      style: GoogleFonts.inter(
                        color: AppColors.textDim,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                  .expand(
                    (widget) => [
                      widget,
                      Text(
                        ' • ',
                        style: GoogleFonts.inter(
                          color: AppColors.textDim,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                  .toList()
                ..removeLast(),
            ),
          ],
        ],
      ),
    );
  }
}
