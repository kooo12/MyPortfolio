import 'package:flutter/material.dart';

class HeroData {
  final String title;
  final String subtitle;
  final String description;
  final String profileImg;

  const HeroData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.profileImg,
  });
}

class AboutData {
  final String title;
  final String bio1;
  final String bio2;
  final List<String> tags;
  final List<StatData> stats;

  const AboutData({
    required this.title,
    required this.bio1,
    required this.bio2,
    required this.tags,
    required this.stats,
  });
}

class StatData {
  final String number;
  final String label;

  const StatData({required this.number, required this.label});
}

class ExperienceData {
  final String company;
  final String role;
  final String period;
  final String description;
  final String companyLogo;
  final List<String> achievements;
  final Color color;

  const ExperienceData({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    required this.companyLogo,
    required this.achievements,
    required this.color,
  });
}

class SkillData {
  final String name;
  final String role;
  final String level;
  final String description;

  const SkillData({
    required this.name,
    required this.role,
    required this.level,
    required this.description,
  });
}

class ProjectData {
  final String title;
  final String description;
  final String image;
  final Color color;
  final List<String> techStack;
  final List<String> responsibilities;
  final List<String> coreFeatures;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? githubUrl;
  final String? webUrl;
  final String category;
  final List<String> appImages;

  const ProjectData({
    required this.title,
    required this.description,
    required this.image,
    required this.color,
    required this.techStack,
    required this.responsibilities,
    required this.coreFeatures,
    required this.category,
    required this.appImages,
    this.playStoreUrl,
    this.appStoreUrl,
    this.githubUrl,
    this.webUrl,
  });
}

class PortfolioData {
  final HeroData hero;
  final AboutData about;
  final List<ExperienceData> experiences;
  final List<SkillData> skills;
  final List<ProjectData> projects;

  const PortfolioData({
    required this.hero,
    required this.about,
    required this.experiences,
    required this.skills,
    required this.projects,
  });
}
