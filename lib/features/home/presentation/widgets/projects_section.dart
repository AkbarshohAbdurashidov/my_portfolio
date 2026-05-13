import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import '../../../../core/utils/responsive.dart';
import 'section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionPaddingV(context),
      ).add(Responsive.pagePadding(context)),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth),
          child: Column(
            children: [
              const SectionHeader(
                tag: 'MY WORK',
                title: 'Projects',
                subtitle: 'Applications I\'ve built and shipped to production',
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 56),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isMobile ? 1.3 : 1.1,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return _ProjectCard(
                    project: projects[index],
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;

  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppColors.primary,
      AppColors.cyan,
      const Color(0xFF8B5CF6),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
    ];
    final cardColor = colors[widget.index % colors.length];

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -4.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A1628), Color(0xFF0D1B35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? cardColor.withOpacity(0.4) : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: cardColor.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cardColor, cardColor.withOpacity(0.5)],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: cardColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: cardColor.withOpacity(0.3)),
                        ),
                        child: Center(
                          child: Text(
                            widget.project.emoji,
                            style: const TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.project.name,
                              style: GoogleFonts.poppins(
                                color: AppColors.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                if (widget.project.appStoreUrl != null)
                                  _StoreBadge(
                                    label: 'App Store',
                                    icon: Icons.apple,
                                    color: cardColor,
                                    onTap: () =>
                                        _launch(widget.project.appStoreUrl!),
                                  ),
                                if (widget.project.playStoreUrl != null) ...[
                                  if (widget.project.appStoreUrl != null)
                                    const SizedBox(width: 8),
                                  _StoreBadge(
                                    label: 'Play Store',
                                    icon: Icons.android,
                                    color: const Color(0xFF10B981),
                                    onTap: () =>
                                        _launch(widget.project.playStoreUrl!),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.project.description,
                    style: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.7,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.project.tags
                        .map((tag) => _Tag(label: tag, color: cardColor))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 200 + widget.index * 100))
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
  }
}

class _StoreBadge extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _StoreBadge({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<_StoreBadge> createState() => _StoreBadgeState();
}

class _StoreBadgeState extends State<_StoreBadge> {
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(_hovered ? 0.2 : 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: widget.color.withOpacity(0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: widget.color, size: 12),
              const SizedBox(width: 4),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  color: widget.color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.open_in_new, color: widget.color, size: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: AppColors.textMuted,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}