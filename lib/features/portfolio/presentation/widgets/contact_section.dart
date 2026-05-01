import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_portfolio/core/services/contact_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../domain/models/portfolio_models.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isSent = false;
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final padding = isMobile ? 24.0 : 96.0;
    final contactData = PortfolioRepository.data.contact;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 96),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.surfaceContainerHighest)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Let's Connect", style: GoogleFonts.spaceGrotesk(color: AppColors.textPrimary, fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.w600)).animate().fadeIn(),
              const SizedBox(height: 8),
              Text('Looking to collaborate on an architecture project or just want to say hi? My inbox is always open.', style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 16, height: 1.6)).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 48),
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: _buildForm(context),
                  ),
                  SizedBox(width: isMobile ? 0 : 48, height: isMobile ? 48 : 0),
                  // Social + Location
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: Column(
                      children: [
                        _buildSocialCard(contactData),
                        const SizedBox(height: 16),
                        _buildLocationCard(contactData),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    if (_isSent) {
      return _buildSuccessView();
    }
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _field('NAME', 'John Doe', _nameCtrl)),
                const SizedBox(width: 16),
                Expanded(child: _field('EMAIL', 'john@example.com', _emailCtrl)),
              ],
            ),
            const SizedBox(height: 24),
            _field('SUBJECT', 'Architecture Consultation', _subjectCtrl),
            const SizedBox(height: 24),
            _field('MESSAGE', 'Tell me about your project...', _messageCtrl, maxLines: 4),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: Colors.redAccent, fontSize: 14)),
            ],
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerRight,
              child: _SendButton(
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _field(String label, String hint, TextEditingController ctrl, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.2)),
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.surfaceContainerHighest),
            filled: false,
            border: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.outlineVariant)),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.outlineVariant)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),
      ],
    );
  }

  Widget _buildSocialCard(ContactData contactData) {
    final socials = [
      {'icon': Icons.code, 'name': 'GitHub', 'handle': '@kooo12'},
      {'icon': Icons.business_center, 'name': 'LinkedIn', 'handle': 'in/aung-ko-oo'},
      {'icon': Icons.chat, 'name': 'Telegram', 'handle': '@kooo2109'},
    ];

    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Social Profiles', style: GoogleFonts.spaceGrotesk(color: AppColors.textPrimary, fontSize: 32, fontWeight: FontWeight.w600)),
          const SizedBox(height: 24),
          ...socials.map((s) => _SocialRow(icon: s['icon'] as IconData, name: s['name'] as String, handle: s['handle'] as String)),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildLocationCard(ContactData contactData) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.location_on, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location', style: GoogleFonts.inter(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
              Text(contactData.location, style: GoogleFonts.inter(color: AppColors.textSecondary)),
              Text('Available for remote opportunities.', style: GoogleFonts.inter(color: AppColors.primary, fontSize: 12)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildSuccessView() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
          const SizedBox(height: 24),
          Text('MESSAGE SENT!', style: GoogleFonts.spaceGrotesk(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text('Thank you for reaching out.', style: GoogleFonts.inter(color: AppColors.textDim, fontSize: 16)),
          const SizedBox(height: 32),
          OutlinedButton(onPressed: () => setState(() { _isSent = false; _error = null; _nameCtrl.clear(); _emailCtrl.clear(); _subjectCtrl.clear(); _messageCtrl.clear(); }), style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.accent)), child: const Text('SEND ANOTHER', style: TextStyle(color: AppColors.accent))),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() { _isLoading = true; _error = null; });
    try {
      final res = await ContactService().sendMessage(
        name: _nameCtrl.text,
        email: _emailCtrl.text,
        subject: _subjectCtrl.text,
        message: _messageCtrl.text,
      );
      if (!mounted) return;
      if (res['success']) { setState(() => _isSent = true); } else { setState(() => _error = res['message']); }
    } catch (_) { if (mounted) setState(() => _error = 'Connection error.'); }
    finally { if (mounted) setState(() => _isLoading = false); }
  }
}

class _SocialRow extends StatefulWidget {
  final IconData icon;
  final String name;
  final String handle;
  const _SocialRow({required this.icon, required this.name, required this.handle});
  @override
  State<_SocialRow> createState() => _SocialRowState();
}

class _SocialRowState extends State<_SocialRow> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              alignment: Alignment.center,
              child: Icon(widget.icon, color: _hovered ? AppColors.primary : AppColors.textSecondary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: GoogleFonts.inter(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
                  Text(widget.handle, style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 14)),
                ],
              ),
            ),
            AnimatedSlide(
              duration: const Duration(milliseconds: 200),
              offset: Offset(_hovered ? 0.1 : 0, 0),
              child: Icon(Icons.north_east, color: _hovered ? AppColors.primary : AppColors.textSecondary, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  const _SendButton({required this.isLoading, required this.onPressed});
  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(4),
            boxShadow: _hovered ? [BoxShadow(color: AppColors.primaryContainer.withValues(alpha: 0.3), blurRadius: 15)] : [],
          ),
          child: widget.isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Send Message', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_right_alt, color: Colors.white, size: 20),
                  ],
                ),
        ),
      ),
    );
  }
}
