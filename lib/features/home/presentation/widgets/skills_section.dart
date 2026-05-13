import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import '../../../../core/utils/responsive.dart';
import 'section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

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
                tag: 'WHAT I USE',
                title: 'My Skills',
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 16),
              Text(
                'Technologies and tools I work with to build amazing products',
                style: GoogleFonts.poppins(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 56),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isMobile ? 1.6 : 1.2,
                ),
                itemCount: skillCategories.length,
                itemBuilder: (context, index) {
                  return _SkillCard(
                    category: skillCategories[index],
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

class _SkillCard extends StatefulWidget {
  final SkillCategory category;
  final int index;

  const _SkillCard({required this.category, required this.index});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A1628), Color(0xFF0D1B35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? widget.category.accentColor.withOpacity(0.5) : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.category.accentColor.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: widget.category.accentColor.withOpacity(_hovered ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: widget.category.accentColor.withOpacity(0.3),
                    ),
                  ),
                  child: Center(
                    child: Text(widget.category.icon, style: const TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.category.title,
                    style: GoogleFonts.poppins(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.category.skills
                    .map((skill) => _SkillChip(skill: skill, color: widget.category.accentColor))
                    .toList(),
              ),
            ),
          ],
        ),
      )
          .animate(delay: Duration(milliseconds: 200 + widget.index * 100))
          .fadeIn(duration: 600.ms)
          .slideY(begin: 0.3, end: 0),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String skill;
  final Color color;

  const _SkillChip({required this.skill, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        skill,
        style: GoogleFonts.poppins(
          color: color.withOpacity(0.9),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

