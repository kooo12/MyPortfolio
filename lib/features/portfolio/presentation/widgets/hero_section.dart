import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final isMobile = size.width < 900;
    final padding = isMobile ? 24.0 : 100.0;
    final titleSize = size.width < 600 ? 32.0 : (isMobile ? 50.0 : 80.0);

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 50),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: isMobile ? 0 : 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    if (isMobile) ...[
                      const _ProfilePhoto(),
                      const SizedBox(height: 40),
                    ],
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.accentGradient.createShader(bounds),
                      child: Text(
                        'HI, I AM AUNG KO OO',
                        textAlign: isMobile
                            ? TextAlign.center
                            : TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textPrimary,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
                    const SizedBox(height: 20),
                    Text(
                          'Flutter Developer\nCrafting Premium\nExperiences.',
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                fontSize: titleSize,
                                height: 1.1,
                                fontWeight: FontWeight.w900,
                              ),
                        )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 800.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 30),
                    Text(
                      '3+ Years Experince | Tech Plus Solutions (TPS)',
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
                    const SizedBox(height: 50),
                  ],
                ),
              ),

              if (!isMobile)
                const Expanded(flex: 2, child: Center(child: _ProfilePhoto())),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto();

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 350,
          height: 350,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.2),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.accent.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.1, 1.1),
                    duration: 2.seconds,
                    curve: Curves.easeInOut,
                  )
                  .fadeOut(),

              ClipOval(
                child: Image.asset(
                  'assets/profile.png',
                  width: 320,
                  height: 320,
                  fit: BoxFit.cover,
                ),
              ),

              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.transparent,
                      AppColors.primary.withValues(alpha: 0.05),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 1.seconds)
        .scale(begin: const Offset(0.8, 0.8))
        .shimmer(delay: 2.seconds, duration: 2.seconds);
  }
}
