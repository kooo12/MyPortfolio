import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/repositories/portfolio_repository.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 96,
        vertical: 48,
      ),
      margin: const EdgeInsets.only(top: 80),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        border: const Border(top: BorderSide(color: Colors.white10)),
      ),
      child: isMobile ? _buildMobile() : _buildDesktop(),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Widget _buildDesktop() {
    final socials = PortfolioRepository.data.contact.socials;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '© 2026 Engineered with Flutter',
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFF4B5563),
            fontSize: 14,
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        Wrap(
          spacing: 24,
          children: socials.map((s) => _FooterLink(
            label: s.name,
            onTap: () => _launchUrl(s.url),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildMobile() {
    final socials = PortfolioRepository.data.contact.socials;
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24,
          runSpacing: 16,
          children: socials.map((s) => _FooterLink(
            label: s.name,
            onTap: () => _launchUrl(s.url),
          )).toList(),
        ),
        const SizedBox(height: 24),
        Text(
          '© 2026 Engineered with Flutter',
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFF4B5563),
            fontSize: 14,
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  const _FooterLink({required this.label, this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.spaceGrotesk(
            color: _isHovered ? AppColors.accent : const Color(0xFF4B5563),
            fontSize: 14,
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
            decoration: _isHovered
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: AppColors.accent,
          ),
          child: Text(widget.label.toUpperCase()),
        ),
      ),
    );
  }
}
