import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

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
        border: const Border(
          top: BorderSide(color: Colors.white10),
        ),
      ),
      child: isMobile ? _buildMobile() : _buildDesktop(),
    );
  }

  Widget _buildDesktop() {
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
        Row(
          children: [
            _FooterLink(label: 'GitHub'),
            const SizedBox(width: 24),
            _FooterLink(label: 'LinkedIn'),
            const SizedBox(width: 24),
            _FooterLink(label: 'Twitter'),
          ],
        ),
      ],
    );
  }

  Widget _buildMobile() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLink(label: 'GitHub'),
            const SizedBox(width: 24),
            _FooterLink(label: 'LinkedIn'),
            const SizedBox(width: 24),
            _FooterLink(label: 'Twitter'),
          ],
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
  const _FooterLink({required this.label});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: GoogleFonts.spaceGrotesk(
          color: _isHovered
              ? AppColors.accent
              : const Color(0xFF4B5563),
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
    );
  }
}
