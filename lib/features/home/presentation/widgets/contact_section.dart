import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../services/telegram_service.dart';
import 'section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      color: AppColors.bg,
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionPaddingV(context),
      ).add(Responsive.pagePadding(context)),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth),
          child: Column(
            children: [
              const SectionHeader(
                tag: 'GET IN TOUCH',
                title: 'Contact Me',
                subtitle: 'Have a project in mind? Let\'s work together!',
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 56),
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 4, child: _ContactInfo()),
                        const SizedBox(width: 40),
                        const Expanded(flex: 6, child: _ContactForm()),
                      ],
                    )
                  : const Column(
                      children: [
                        _ContactInfo(),
                        SizedBox(height: 40),
                        _ContactForm(),
                      ],
                    ),
              const SizedBox(height: 60),
              const _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s build something\namazing together.',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m open to freelance projects, full-time positions, and exciting collaborations. Feel free to reach out!',
          style: GoogleFonts.poppins(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        _ContactItem(
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'akbarshohabdurashidov@gmail.com',
          url: 'mailto:akbarshohabdurashidov@gmail.com',
        ),
        const SizedBox(height: 16),
        _ContactItem(
          icon: Icons.send_outlined,
          label: 'Telegram',
          value: '@Akbarshokh_Abdurashidov',
          url: 'https://t.me/Akbarshokh_Abdurashidov',
        ),
        const SizedBox(height: 32),
        Text(
          'Find me on',
          style: GoogleFonts.poppins(
            color: AppColors.textMuted,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _SocialButton(
              icon: Icons.code,
              label: 'GitHub',
              url: 'https://github.com/AkbarshohAbdurashidov',
            ),
            const SizedBox(width: 12),
            _SocialButton(
              icon: Icons.work_outline,
              label: 'LinkedIn',
              url: 'https://www.linkedin.com/in/akbarshoh-abdurashidov-60420625b/',
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.3, end: 0);
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primary.withOpacity(0.08) : AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppColors.primary.withOpacity(0.4) : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: GoogleFonts.poppins(
                      color: AppColors.textMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.value,
                    style: GoogleFonts.poppins(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.open_in_new,
                color: _hovered ? AppColors.accent : AppColors.textMuted,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialButton({required this.icon, required this.label, required this.url});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primary.withOpacity(0.1) : AppColors.card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: _hovered ? AppColors.accent : AppColors.textSecondary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  color: _hovered ? AppColors.accent : AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _loading = false;
  String? _feedback;
  bool _isSuccess = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _feedback = null;
    });

    final success = await TelegramService.sendContactMessage(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      message: _messageController.text.trim(),
    );

    if (!mounted) return;
    setState(() {
      _loading = false;
      _isSuccess = success;
      _feedback = success
          ? 'Message sent! I\'ll get back to you soon. 🎉'
          : 'Message sent! You can also reach me directly on Telegram.';
    });

    if (success) {
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A1628), Color(0xFF0D1B35)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Message',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            _FormField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'Your full name',
              icon: Icons.person_outline,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'your@email.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Please enter your email';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell me about your project...',
              icon: Icons.message_outlined,
              maxLines: 5,
              validator: (v) =>
                  (v == null || v.trim().length < 10)
                      ? 'Message must be at least 10 characters'
                      : null,
            ),
            const SizedBox(height: 24),
            if (_feedback != null)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: (_isSuccess ? AppColors.success : AppColors.accent)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (_isSuccess ? AppColors.success : AppColors.accent)
                        .withOpacity(0.4),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isSuccess ? Icons.check_circle_outline : Icons.info_outline,
                      color: _isSuccess ? AppColors.success : AppColors.accent,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _feedback!,
                        style: GoogleFonts.poppins(
                          color: _isSuccess ? AppColors.success : AppColors.accent,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: _SendButton(onTap: _submit, loading: _loading),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: 0.3, end: 0);
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.poppins(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.textMuted, size: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool loading;

  const _SendButton({required this.onTap, required this.loading});

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.loading ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: widget.loading ? null : AppColors.primaryGradient,
            color: widget.loading ? AppColors.border : null,
            borderRadius: BorderRadius.circular(12),
            boxShadow: !widget.loading && _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.loading)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.accent,
                  ),
                )
              else
                const Icon(Icons.send_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                widget.loading ? 'Sending...' : 'Send Message',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppColors.border),
        const SizedBox(height: 24),
        Text(
          '© 2026 Akbarshoh Abdurashidov. Built with Flutter 💙',
          style: GoogleFonts.poppins(
            color: AppColors.textMuted,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Flutter Mobile Developer · Tashkent, Uzbekistan',
          style: GoogleFonts.poppins(
            color: AppColors.textMuted.withOpacity(0.6),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}