import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/nav_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _navScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 50;
      if (scrolled != _navScrolled) setState(() => _navScrolled = scrolled);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 72),
                HeroSection(
                  key: _heroKey,
                  onViewProjects: () => _scrollTo(_projectsKey),
                  onContact: () => _scrollTo(_contactKey),
                ),
                AboutSection(key: _aboutKey),
                SkillsSection(key: _skillsKey),
                ProjectsSection(key: _projectsKey),
                ContactSection(key: _contactKey),
              ],
            ),
          ),
          NavBar(
            isScrolled: _navScrolled,
            onAbout: () => _scrollTo(_aboutKey),
            onSkills: () => _scrollTo(_skillsKey),
            onProjects: () => _scrollTo(_projectsKey),
            onContact: () => _scrollTo(_contactKey),
            onHome: () => _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOutCubic,
            ),
          ),
        ],
      ),
    );
  }
}