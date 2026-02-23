import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:new_portfolio/core/services/contact_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../data/repositories/portfolio_repository.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _isSent = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_clearError);
    _emailController.addListener(_clearError);
    _messageController.addListener(_clearError);
  }

  @override
  void dispose() {
    _nameController.removeListener(_clearError);
    _emailController.removeListener(_clearError);
    _messageController.removeListener(_clearError);
    super.dispose();
  }

  void _clearError() {
    if (_errorMessage != null) {
      setState(() => _errorMessage = null);
    }
  }

  void _resetForm() {
    setState(() {
      _isSent = false;
      _errorMessage = null;
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final padding = isMobile ? 24.0 : 100.0;

    final contactData = PortfolioRepository.data.contact;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GET IN TOUCH',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.accent,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slideX(begin: -0.1),
          const SizedBox(height: 50),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: isMobile ? 0 : 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ContactInfoItem(
                      icon: Icons.email_rounded,
                      title: 'Email',
                      value: contactData.email,
                      delay: 100,
                    ),
                    _ContactInfoItem(
                      icon: Icons.phone_rounded,
                      title: 'Phone',
                      value: contactData.phone,
                      delay: 200,
                    ),
                    _ContactInfoItem(
                      icon: Icons.location_on_rounded,
                      title: 'Location',
                      value: contactData.location,
                      delay: 300,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'SOCIALS',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textDim,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 400.ms),
                    const SizedBox(height: 20),
                    Row(
                      children: contactData.socials.asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final social = entry.value;
                        return _SocialButton(
                          icon: social.icon,
                          delay: (500 + (index * 100)).toInt(),
                          onTap: () {
                            launchUrl(Uri.parse(social.url));
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              if (isMobile) const SizedBox(height: 60),
              if (!isMobile) const SizedBox(width: 60),

              Expanded(
                flex: isMobile ? 0 : 3,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.1),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                  child: _isSent
                      ? _SuccessView(
                          key: const ValueKey('success'),
                          onReset: _resetForm,
                        )
                      : GlassContainer(
                          key: const ValueKey('form'),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: _form,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _ContactField(
                                    label: 'Name',
                                    hint: 'Your Name',
                                    controller: _nameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  _ContactField(
                                    label: 'Email',
                                    hint: 'Your Email',
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  _ContactField(
                                    label: 'Message',
                                    hint: 'Your Message',
                                    maxLines: 2,
                                    controller: _messageController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your message';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 40),
                                  if (_errorMessage != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child:
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red.withValues(
                                                alpha: 0.1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.red.withValues(
                                                  alpha: 0.2,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.error_outline_rounded,
                                                  color: Colors.redAccent,
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    _errorMessage!,
                                                    style: const TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).animate().shake(
                                            hz: 4,
                                            curve: Curves.easeInOut,
                                          ),
                                    ),
                                  _SendButton(
                                    formKey: _form,
                                    nameController: _nameController,
                                    emailController: _emailController,
                                    messageController: _messageController,
                                    onSuccess: () =>
                                        setState(() => _isSent = true),
                                    onError: (error) =>
                                        setState(() => _errorMessage = error),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final int delay;

  const _ContactInfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.textDim, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.1);
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final int delay;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.delay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: FaIcon(icon, color: AppColors.textPrimary, size: 20),
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).scale();
  }
}

class _ContactField extends StatelessWidget {
  final String label;
  final String hint;

  final int maxLines;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const _ContactField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          style: const TextStyle(color: AppColors.textPrimary),
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.3),
            ),
            filled: true,

            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.accent),
            ),
          ),
        ),
      ],
    );
  }
}

class _SendButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final VoidCallback onSuccess;
  final Function(String) onError;

  const _SendButton({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.onSuccess,
    required this.onError,
  });

  @override
  _SendButtonState createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.accent,
          elevation: 8,
          shadowColor: AppColors.accent.withValues(alpha: 0.3),
        ),
        onPressed: _isLoading
            ? null
            : () async {
                if (widget.formKey.currentState?.validate() ?? false) {
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    final response = await ContactService().sendMessage(
                      name: widget.nameController.text,
                      email: widget.emailController.text,
                      message: widget.messageController.text,
                    );

                    if (!mounted) return;

                    if (response['success']) {
                      widget.onSuccess();
                    } else {
                      widget.onError(response['message']);
                    }
                  } catch (e) {
                    if (mounted) {
                      widget.onError('Connection error. Please try again.');
                    }
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                }
              },
        child: _isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'SEND MESSAGE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final VoidCallback onReset;

  const _SuccessView({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
                size: 60,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'MESSAGE SENT!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Thank you for reaching out. I will get back to you as soon as possible.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textDim,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            OutlinedButton(
              onPressed: onReset,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                side: const BorderSide(color: AppColors.accent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'SEND ANOTHER MESSAGE',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
