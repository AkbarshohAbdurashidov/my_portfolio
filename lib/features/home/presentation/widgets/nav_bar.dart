import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class NavBar extends StatefulWidget {
  final bool isScrolled;
  final VoidCallback onHome;
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  const NavBar({
    super.key,
    required this.isScrolled,
    required this.onHome,
    required this.onAbout,
    required this.onSkills,
    required this.onProjects,
    required this.onContact,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _mobileMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 72,
          decoration: BoxDecoration(
            color: widget.isScrolled ? AppColors.navBg : Colors.transparent,
            border: widget.isScrolled
                ? const Border(
                    bottom: BorderSide(color: AppColors.border, width: 0.5),
                  )
                : null,
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.isScrolled ? 12 : 0,
                sigmaY: widget.isScrolled ? 12 : 0,
              ),
              child: Padding(
                padding: Responsive.pagePadding(context),
                child: Row(
                  children: [
                    _Logo(onTap: widget.onHome),
                    const Spacer(),
                    if (!isMobile) ...[
                      _NavLink(label: 'About', onTap: widget.onAbout),
                      const SizedBox(width: 8),
                      _NavLink(label: 'Skills', onTap: widget.onSkills),
                      const SizedBox(width: 8),
                      _NavLink(label: 'Projects', onTap: widget.onProjects),
                      const SizedBox(width: 8),
                      const SizedBox(width: 8),
                      _ContactButton(onTap: widget.onContact),
                    ] else ...[
                      IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            _mobileMenuOpen ? Icons.close : Icons.menu,
                            key: ValueKey(_mobileMenuOpen),
                            color: AppColors.textPrimary,
                            size: 24,
                          ),
                        ),
                        onPressed: () =>
                            setState(() => _mobileMenuOpen = !_mobileMenuOpen),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.5, end: 0),
        if (isMobile && _mobileMenuOpen)
          _MobileMenu(
            onAbout: () {
              setState(() => _mobileMenuOpen = false);
              widget.onAbout();
            },
            onSkills: () {
              setState(() => _mobileMenuOpen = false);
              widget.onSkills();
            },
            onProjects: () {
              setState(() => _mobileMenuOpen = false);
              widget.onProjects();
            },
            onContact: () {
              setState(() => _mobileMenuOpen = false);
              widget.onContact();
            },
          ).animate().fadeIn(duration: 200.ms).slideY(begin: -0.1, end: 0),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'AA',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Akbarshoh',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _hovered
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.poppins(
              color: _hovered ? AppColors.accent : AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final VoidCallback onTap;

  const _ContactButton({required this.onTap});

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: _hovered ? AppColors.primaryGradient : null,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                    ),
                  ]
                : null,
          ),
          child: Text(
            'Contact',
            style: GoogleFonts.poppins(
              color: _hovered ? Colors.white : AppColors.accent,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  const _MobileMenu({
    required this.onAbout,
    required this.onSkills,
    required this.onProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.navBg,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MobileLink(label: 'About', onTap: onAbout),
          _MobileLink(label: 'Skills', onTap: onSkills),
          _MobileLink(label: 'Projects', onTap: onProjects),
          _MobileLink(label: 'Contact', onTap: onContact, isLast: true),
        ],
      ),
    );
  }
}

class _MobileLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLast;

  const _MobileLink({
    required this.label,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(
                  bottom: BorderSide(color: AppColors.border, width: 0.5),
                ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
