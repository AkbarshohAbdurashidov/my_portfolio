import 'package:flutter/material.dart';

class SkillCategory {
  final String title;
  final String icon;
  final List<String> skills;
  final Color accentColor;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
    required this.accentColor,
  });
}

class ProjectModel {
  final String name;
  final String description;
  final String emoji;
  final List<String> tags;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String? githubUrl;

  const ProjectModel({
    required this.name,
    required this.description,
    required this.emoji,
    required this.tags,
    this.appStoreUrl,
    this.playStoreUrl,
    this.githubUrl,
  });
}

class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final List<String> highlights;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.highlights,
  });
}

const List<SkillCategory> skillCategories = [
  SkillCategory(
    title: 'Mobile Development',
    icon: '📱',
    accentColor: Color(0xFF3B82F6),
    skills: ['Flutter', 'Dart', 'Swift', 'Java', 'Kotlin', 'iOS', 'Android'],
  ),
  SkillCategory(
    title: 'Backend & Cloud',
    icon: '☁️',
    accentColor: Color(0xFF22D3EE),
    skills: ['Firebase', 'Supabase', 'REST API', 'Auth Systems', 'Real-time DB'],
  ),
  SkillCategory(
    title: 'Databases',
    icon: '🗄️',
    accentColor: Color(0xFF8B5CF6),
    skills: ['MongoDB', 'PostgreSQL', 'SQL', 'Hive', 'SharedPrefs'],
  ),
  SkillCategory(
    title: 'Tools & Practices',
    icon: '🛠️',
    accentColor: Color(0xFF10B981),
    skills: ['Git & GitHub', 'Docker', 'Clean Architecture', 'MVVM', 'App Store', 'Google Play'],
  ),
];

const List<ProjectModel> projects = [
  ProjectModel(
    name: 'Viora',
    emoji: '✨',
    description:
        'AI-powered visual analysis and lifestyle mobile application successfully published on the Apple App Store.',
    tags: ['Flutter', 'AI', 'iOS', 'App Store'],
    appStoreUrl: 'https://apps.apple.com/us/app/viora/id6755075815',
  ),
  ProjectModel(
    name: 'Felixzoo',
    emoji: '🛍️',
    description:
        'Large-scale e-commerce and delivery platform with scalable backend integration, real-time services, and modern responsive UI.',
    tags: ['Flutter', 'Firebase', 'E-Commerce', 'Real-time'],
  ),
  ProjectModel(
    name: 'Nextin Attendance',
    emoji: '📅',
    description:
        'Employee attendance and workforce management application developed at Nextin Web Studio for production use.',
    tags: ['Flutter', 'REST API', 'MVVM', 'HR'],
    playStoreUrl: 'https://play.google.com/store',
  ),
  ProjectModel(
    name: 'Nextin CRM',
    emoji: '💼',
    description:
        'Business automation and CRM platform focused on workflow, employee, and client management systems.',
    tags: ['Flutter', 'Clean Arch', 'CRM', 'Business'],
    playStoreUrl: 'https://play.google.com/store',
  ),
  ProjectModel(
    name: 'Library CRM',
    emoji: '📚',
    description:
        'Modern library management and CRM application built with Flutter using scalable architecture and cross-platform design.',
    tags: ['Flutter', 'Supabase', 'Cross-platform', 'MVVM'],
  ),
];

const List<ExperienceModel> experiences = [
  ExperienceModel(
    role: 'Flutter Mobile Developer',
    company: 'Nextin Web Studio',
    period: '2026 — Present',
    highlights: [
      'Developing scalable mobile applications using Flutter',
      'Building responsive and modern user interfaces',
      'Working with APIs, authentication systems, and backend integrations',
      'Contributing to production-level business applications',
    ],
  ),
  ExperienceModel(
    role: 'Freelance Mobile Developer',
    company: 'Self-employed',
    period: '2023 — 2026',
    highlights: [
      'Developed and deployed mobile applications independently',
      'Published applications on the Apple App Store',
      'Worked on custom mobile solutions for different clients',
    ],
  ),
];