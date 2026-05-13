import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: screenHeight - 72),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF050B18), Color(0xFF080F1E), Color(0xFF050B18)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          const _BackgroundDecor(),
          Padding(
            padding: Responsive.pagePadding(context).add(
              EdgeInsets.symmetric(vertical: isDesktop ? 60 : 40),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Responsive.maxWidth),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: _HeroContent(
                              onViewProjects: onViewProjects,
                              onContact: onContact,
                            ),
                          ),
                          const SizedBox(width: 60),
                          const Expanded(
                            flex: 4,
                            child: _TerminalCard(),
                          ),
                        ],
                      )
                    : _HeroContent(
                        onViewProjects: onViewProjects,
                        onContact: onContact,
                        centered: true,
                      ),
              ),
            ),
          ),
          const _ScrollIndicator(),
        ],
      ),
    );
  }
}

class _BackgroundDecor extends StatelessWidget {
  const _BackgroundDecor();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.cyan.withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryLight.withOpacity(0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;
  final bool centered;

  const _HeroContent({
    required this.onViewProjects,
    required this.onContact,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hello, I\'m 👋',
          style: GoogleFonts.poppins(
            color: AppColors.accent,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.3, end: 0),
        const SizedBox(height: 12),
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.titleGradient.createShader(bounds),
          child: Text(
            'Akbarshoh\nAbdurashidov',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: Responsive.isMobile(context) ? 38 : 52,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -1,
            ),
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: -0.3, end: 0),
        const SizedBox(height: 20),
        _TypewriterText(
          texts: const [
            'Flutter Mobile Developer',
            'iOS App Developer',
            'Cross-Platform Expert',
            'Mobile UI Architect',
          ],
        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Building stunning, production-ready mobile applications with Flutter & Swift. Turning ideas into high-performance cross-platform experiences.',
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.7,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.start,
          ),
        ).animate().fadeIn(delay: 700.ms, duration: 600.ms),
        const SizedBox(height: 36),
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 12,
          children: [
            _PrimaryButton(label: 'View Projects', onTap: onViewProjects),
            _OutlineButton(label: 'Contact Me', onTap: onContact),
          ],
        ).animate().fadeIn(delay: 900.ms, duration: 600.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment:
              centered ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _SocialIcon(
              icon: Icons.code,
              label: 'GitHub',
              url: 'https://github.com/AkbarshohAbdurashidov',
            ),
            const SizedBox(width: 16),
            _SocialIcon(
              icon: Icons.work_outline,
              label: 'LinkedIn',
              url: 'https://www.linkedin.com/in/akbarshoh-abdurashidov-60420625b/',
            ),
            const SizedBox(width: 16),
            _SocialIcon(
              icon: Icons.send,
              label: 'Telegram',
              url: 'https://t.me/Akbarshokh_Abdurashidov',
            ),
          ],
        ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
      ],
    );
  }
}

class _TypewriterText extends StatefulWidget {
  final List<String> texts;
  const _TypewriterText({required this.texts});

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText> {
  int _textIndex = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  bool _showCursor = true;
  Timer? _typingTimer;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 530), (_) {
      if (mounted) setState(() => _showCursor = !_showCursor);
    });
    _scheduleNext(500);
  }

  void _tick() {
    if (!mounted) return;
    final text = widget.texts[_textIndex];

    setState(() {
      if (!_isDeleting) {
        if (_charIndex < text.length) {
          _charIndex++;
          _scheduleNext(90);
        } else {
          _scheduleNext(2200, startDeleting: true);
        }
      } else {
        if (_charIndex > 0) {
          _charIndex--;
          _scheduleNext(50);
        } else {
          _isDeleting = false;
          _textIndex = (_textIndex + 1) % widget.texts.length;
          _scheduleNext(300);
        }
      }
    });
  }

  void _scheduleNext(int ms, {bool startDeleting = false}) {
    _typingTimer?.cancel();
    if (startDeleting) _isDeleting = true;
    _typingTimer = Timer(Duration(milliseconds: ms), _tick);
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayText = widget.texts[_textIndex].substring(0, _charIndex);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          displayText,
          style: GoogleFonts.poppins(
            color: AppColors.cyan,
            fontSize: Responsive.isMobile(context) ? 18 : 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        AnimatedOpacity(
          opacity: _showCursor ? 1 : 0,
          duration: const Duration(milliseconds: 100),
          child: Text(
            '|',
            style: GoogleFonts.poppins(
              color: AppColors.primary,
              fontSize: Responsive.isMobile(context) ? 18 : 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(_hovered ? 0.5 : 0.3),
                blurRadius: _hovered ? 24 : 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.onTap});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.poppins(
              color: _hovered ? AppColors.accent : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  const _SocialIcon({required this.icon, required this.label, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primary.withOpacity(0.15) : AppColors.card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.border,
            ),
            boxShadow: _hovered
                ? [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 12)]
                : null,
          ),
          child: Icon(
            widget.icon,
            color: _hovered ? AppColors.accent : AppColors.textSecondary,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _TerminalCard extends StatelessWidget {
  const _TerminalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A1628),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 50,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF0D1B35),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                _Dot(color: const Color(0xFFFF5F57)),
                const SizedBox(width: 6),
                _Dot(color: const Color(0xFFFFBD2E)),
                const SizedBox(width: 6),
                _Dot(color: const Color(0xFF28CA41)),
                const Spacer(),
                Text(
                  'developer.dart',
                  style: GoogleFonts.firaCode(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CodeLine('class AkbarshohDev {', Colors.cyan),
                const SizedBox(height: 8),
                _CodeLine('  final String name =', AppColors.textSecondary),
                _CodeLine('    "Akbarshoh Abdurashidov";', const Color(0xFFA3E635)),
                const SizedBox(height: 8),
                _CodeLine('  final String role =', AppColors.textSecondary),
                _CodeLine('    "Flutter Mobile Developer";', const Color(0xFFA3E635)),
                const SizedBox(height: 8),
                _CodeLine('  final int experience = 3;', AppColors.textSecondary),
                const SizedBox(height: 8),
                _CodeLine('  final List<String> stack = [', AppColors.textSecondary),
                _CodeLine('    "Flutter", "Swift",', const Color(0xFFA3E635)),
                _CodeLine('    "Firebase", "Dart",', const Color(0xFFA3E635)),
                _CodeLine('  ];', AppColors.textSecondary),
                const SizedBox(height: 8),
                _CodeLine('  final bool available = true;', const Color(0xFF60A5FA)),
                const SizedBox(height: 8),
                _CodeLine('}', Colors.cyan),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      '> ',
                      style: GoogleFonts.firaCode(
                        color: AppColors.success,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'flutter run --release ',
                      style: GoogleFonts.firaCode(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const _BlinkingCursor(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideX(begin: 0.3, end: 0);
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

Widget _CodeLine(String text, Color color) {
  return Text(
    text,
    style: GoogleFonts.firaCode(color: color, fontSize: 13, height: 1.6),
  );
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor> {
  bool _visible = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 600), (_) {
      if (mounted) setState(() => _visible = !_visible);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 100),
      child: Text(
        '█',
        style: GoogleFonts.firaCode(color: AppColors.accent, fontSize: 13),
      ),
    );
  }
}

class _ScrollIndicator extends StatelessWidget {
  const _ScrollIndicator();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Text(
            'Scroll down',
            style: GoogleFonts.poppins(
              color: AppColors.textMuted,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 1.5,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ).animate(onPlay: (c) => c.repeat()).fadeIn(duration: 1.seconds).then().fadeOut(duration: 1.seconds),
    );
  }
}