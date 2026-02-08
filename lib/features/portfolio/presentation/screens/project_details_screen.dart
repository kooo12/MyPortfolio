import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_image.dart';
import '../../domain/models/portfolio_models.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectData project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  late ScrollController _galleryController;

  @override
  void initState() {
    super.initState();
    _galleryController = ScrollController();
  }

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.4,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: const Icon(Icons.close, color: AppColors.textPrimary),
              onPressed: () => Navigator.pop(context),
            ),

            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () {
                  context.push(
                    '/image-viewer',
                    extra: {
                      'images': [widget.project.image],
                      'initialIndex': 0,
                      'heroTagPrefix': 'project_image_${widget.project.title}',
                    },
                  );
                },
                child: Hero(
                  tag: 'project_image_${widget.project.title}_0',
                  child: AppImage(
                    path: widget.project.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : size.width * 0.1,
              vertical: 40,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildHeader(context, isMobile),
                const SizedBox(height: 30),
                _buildGallery(context),
                const SizedBox(height: 40),
                _buildDescription(context),
                const SizedBox(height: 40),
                _buildFeatureAndResponsibilities(context, isMobile),
                const SizedBox(height: 40),
                _buildTechStack(context),
                const SizedBox(height: 60),
                _buildActionButtons(context, isMobile),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.project.color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.project.color.withValues(alpha: 0.5),
                ),
              ),
              child: Text(
                widget.project.category,
                style: TextStyle(
                  color: widget.project.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          widget.project.title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ).animate().fadeIn().slideX();
  }

  Widget _buildGallery(BuildContext context) {
    return SizedBox(
      height: 320, // Increased height to accommodate scrollbar
      child: Scrollbar(
        controller: _galleryController,
        thumbVisibility: true,
        thickness: 6,
        radius: const Radius.circular(3),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ListView.separated(
            controller: _galleryController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.project.appImages.length,
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              final heroTagPrefix = 'project_gallery_${widget.project.title}';
              return GestureDetector(
                onTap: () {
                  context.push(
                    '/image-viewer',
                    extra: {
                      'images': widget.project.appImages,
                      'initialIndex': index,
                      'heroTagPrefix': heroTagPrefix,
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: '${heroTagPrefix}_$index',
                    child: AppImage(
                      path: widget.project.appImages[index],
                      width: 500,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ).animate().fadeIn(delay: 200.ms).scale(),
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: 'Overview', color: widget.project.color),
        const SizedBox(height: 16),
        Text(
          widget.project.description,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureAndResponsibilities(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          _buildFeatureList(context),
          const SizedBox(height: 40),
          _buildResponsibilityList(context),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildFeatureList(context)),
        const SizedBox(width: 40),
        Expanded(child: _buildResponsibilityList(context)),
      ],
    );
  }

  Widget _buildFeatureList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: 'Core Features', color: widget.project.color),
        const SizedBox(height: 16),
        ...widget.project.coreFeatures.map((f) => _BulletPoint(text: f)),
      ],
    );
  }

  Widget _buildResponsibilityList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: 'Responsibilities', color: widget.project.color),
        const SizedBox(height: 16),
        ...widget.project.responsibilities.map((r) => _BulletPoint(text: r)),
      ],
    );
  }

  Widget _buildTechStack(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: 'Technologies Used', color: widget.project.color),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: widget.project.techStack
              .map((tech) => _TechChip(label: tech))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isMobile) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        if (widget.project.githubUrl != null)
          _ActionButton(
            label: 'GitHub',
            icon: FontAwesomeIcons.github,
            url: widget.project.githubUrl!,
            color: AppColors.textPrimary,
          ),
        if (widget.project.webUrl != null)
          _ActionButton(
            label: 'Live Demo',
            icon: FontAwesomeIcons.globe,
            url: widget.project.webUrl!,
            color: AppColors.accent,
          ),
        if (widget.project.playStoreUrl != null)
          _ActionButton(
            label: 'Play Store',
            icon: FontAwesomeIcons.googlePlay,
            url: widget.project.playStoreUrl!,
            color: Colors.greenAccent,
          ),
        if (widget.project.appStoreUrl != null)
          _ActionButton(
            label: 'App Store',
            icon: FontAwesomeIcons.apple,
            url: widget.project.appStoreUrl!,
            color: Colors.white70,
          ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Icon(Icons.circle, size: 6, color: AppColors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textDim,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;
  final Color color;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.url,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.5)),
            color: color.withValues(alpha: 0.1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icon, color: color, size: 18),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
