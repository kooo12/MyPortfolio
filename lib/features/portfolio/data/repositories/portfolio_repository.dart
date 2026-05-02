import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/models/portfolio_models.dart';
import '../../../../core/theme/app_colors.dart';

class PortfolioRepository {
  static const PortfolioData data = PortfolioData(
    hero: HeroData(
      title: 'HI, I AM AUNG KO OO',
      subtitle: 'Engineering Fluid\nCross-Platform\nExperiences',
      description:
          'Mid-Level Flutter Developer specializing in high-performance architectural patterns, clean code, and seamless UI/UX across iOS and Android ecosystems.',
      profileImg: 'assets/profile.png',
    ),
    about: AboutData(
      title: 'Built on Precision & Clean Code',
      bio1:
          'My approach to mobile development roots deeply in architectural precision. I believe that a fluid user experience is directly tied to the robustness of the underlying codebase. Leveraging advanced Flutter capabilities, I architect scalable solutions that balance immediate feature delivery with long-term maintainability.',
      bio2:
          'From complex state management to custom render objects, my focus remains on creating premium, jank-free interfaces that feel native to every platform.',
      tags: ['Flutter', 'Dart', 'REST API', 'Firebase', 'Clean Architecture'],
      stats: [
        StatData(number: '3+', label: 'Years Experience'),
        StatData(number: '7+', label: 'Projects Completed'),
        StatData(number: '5+', label: 'Happy Clients'),
      ],
    ),
    experiences: [
      ExperienceData(
        company: 'Tech Plus Solutions (TPS)',
        role: 'Mid-Senior Flutter Developer',
        period: '2022 - Present',
        website: 'https://techplussolution.com/',
        description:
            'Spearheaded the migration of legacy native apps to a unified Flutter architecture. Reduced crash rates by 40% and improved team velocity by establishing strict CI/CD pipelines and a modular code structure based on Clean Architecture principles.',
        companyLogo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWzDTATsx7NXuH2TX1sXIAdpcwhlmCJSMY5w&s",
        achievements: [
          "Built end-to-end Flutter frontends for enterprise-grade mobile applications, integrating custom REST APIs, authentication systems, and socket-based real-time services.",
          "Implemented secure multi-provider authentication flows including Google, Apple, phone-number, and username login.",
          "Executed complex application workflows including background location tracking, digital wallet operations, order and delivery lifecycle management, and real-time notifications.",
          "Optimized app performance, implemented theme systems (light/dark and user-role-based theming), multilingual UI (English & Myanmar), and OTA version prompts.",
          "Implemented state-management architectures including GetX, Provider, and BLoC ensuring scalability and maintainability, responsive and pixel-perfect UI/UX designs for mobile applications.",
          "Collaborated closely with the backend engineering team to refine API contracts, scalability strategies, and deployment workflows.",
          'Optimized app performance, reducing startup time by 40%.',
          'Implemented a robust CI/CD pipeline for automated testing and deployment.',
        ],
        color: AppColors.primary,
      ),
      ExperienceData(
        company: 'Ruby Learnner',
        role: 'Junior Flutter Developer',
        period: '2020 - 2021',
        description:
            "Learned and Developed MVP applications for early-stage startups. Focused heavily on rapid prototyping, fluid UI animations, and integrating complex RESTful APIs and Firebase backend services.",
        companyLogo:
            "data:image/jpeg;base64,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",

        achievements: [
          "Learned and Developed first commercial mobile application",
          "Learned state management patterns (Provider, BLoC, GetX)",
          "Contributed to open-source Flutter packages",
          "Completed Flutter principal, consepts and advanced courses",
        ],
        color: AppColors.warmTeal,
      ),
    ],
    skills: [
      SkillData(
        name: 'Flutter',
        role: 'Cross-Platform Framework',
        level: '01',
        description:
            'Expert in building high-performance, beautiful mobile applications using Flutter.',
      ),
      SkillData(
        name: 'Dart',
        role: 'Core Language',
        level: '02',
        description:
            'Deep understanding of Dart language features, async programming, and efficient code practices.',
      ),
      SkillData(
        name: 'Firebase',
        role: 'Backend as a Service',
        level: '03',
        description:
            'Proficient in using Firestore, Cloud Functions, Auth, and Storage for scalable serverless backends.',
      ),
      SkillData(
        name: 'Clean Arch',
        role: 'Scalable Design Pattern',
        level: '04',
        description:
            'State Management: BLoC, Riverpod, GetX.\nFocus on testability and separation of concerns.',
      ),
      SkillData(
        name: 'Rest API',
        role: 'Network Communication',
        level: '05',
        description:
            'Integrating complex RESTful APIs with error handling, caching, and secure token management.',
      ),
      SkillData(
        name: 'Git',
        role: 'Version Control',
        level: '06',
        description:
            'Comfortable with branching strategies, merge conflicts resolution, and CI/CD workflows.',
      ),
    ],
    projects: [
      ProjectData(
        title: 'Velo Music Player',
        description:
            "A music player app with a modern glamorous UI and smooth animations. Features smooth animations and offline support. It supports mp3, wav, m4a, and other audio formats.",
        image:
            // 'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/Velo%20Music%20Player/app_icon.png',
            'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/Velo%20Music%20Player/velo_poster.png?updatedAt=1777713525688',
        appIcon:
            'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/Velo%20Music%20Player/app_icon.png',
        color: AppColors.primary,
        techStack: [
          "Flutter",
          "Firebase",
          "Firestore",
          "REST APIs",
          "Hosting",
          "GetX",
          "SQLite",
          "Audio Engine",
          "Animations",
        ],
        category: 'Mobile',
        responsibilities: [
          "Developed complete UI and state management for mobile app.",
          "Integrated Firebase Firestore Database for fcm tokens and others.",
          "Implemented admin access for push notifications, manage users, fcm tokens and other features.",
          "Implemented offline support for audio playback",
          "Implemented rich features - Sleep timer, Playlist, Shuffle, Repeat, Smart Recommendation and more",
          "Implemented two language support - English and Myanmar",
          "Implemented theme modes",
        ],
        coreFeatures: [
          "Offline support for audio playback",
          "Audio player with smooth animations",
          "Rich features - Sleep timer, Playlist, Shuffle, Repeat, Smart Recommendation and more",
          "Two language support - English and Myanmar",
          "Many theme modes",
          "Admin access for push notifications, manage users and fcm tokens",
        ],
        appImages: [
          'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/Velo%20Music%20Player/velo_poster.png?updatedAt=1777713525688',
          'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/Velo%20Music%20Player/velo_poster_library.png?updatedAt=1777713525266',
          'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/Velo%20Music%20Player/velo_promotional_image.png',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.ako.velo',
        githubUrl: 'https://github.com/kooo12/velo_music',
        webUrl: 'https://velo-music.web.app',
        liveDemo: 'https://velo-live-demo.web.app',
      ),
      ProjectData(
        title: 'Htun Pauk Fuel Energy & Logistics Management System',
        description:
            "A comprehensive fuel management system for logistics companies, featuring real-time tracking, automated reporting, and driver management. Built with Flutter for cross-platform support.A full-stack logistics and fuel distribution platform for businesses and transportation fleets",
        image:
            'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/HtunPauk/htunpauk_store_icon-2.png',
        appIcon:
            'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/HtunPauk/htunpauk_store_icon-2.png',
        color: AppColors.primary,
        techStack: [
          "Flutter",
          "GetX",
          "Provider",
          "REST APIs",
          "Firebase",
          "Firebase",
          "Socket.io",
          "Map Box",
        ],
        category: 'Client Project',
        responsibilities: [
          "Architected and developed full Flutter mobile app UI and logic.",
          "Integrated custom backend services, socket connections, and FCM.",
          "Implemented complex workflows including location tracking, order management, and notifications.",
        ],
        coreFeatures: [
          "Multi-auth login: Apple, Google, phone, username",
          "Background location tracking for drivers",
          "Real-time map with driver & station tracking",
          "Socket-based chat: voice, text, images, videos and files",
          "Push notifications with FCM tokens",
          "Multi-order workflows & driver assignment",
          "Admin dashboard for order management, driver management, user management, and others",
          "Invoice generation (save/share PDF)",
          "Force update system & version control UI",
          "Digital wallet for users & drivers, transaction history",
          "Admin reporting dashboards",
          "Dual-language UI (Myanmar, English)",
          "Dark & light modes + user-role themes",
        ],
        appImages: [
          'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/HtunPauk/htunpauk_store_icon-2.png',
          'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/HtunPauk/Screenshot%202025-11-27%20at%202.50.55%E2%80%AFPM.png?updatedAt=1770569033146',
        ],
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.tps.htunpauk&hl=en",
        appStoreUrl: 'https://apps.apple.com/us/app/htunpauk/id6742842928',
        webUrl: 'https://htunpauk.com',
      ),
      ProjectData(
        title: "MeexU Dating App",
        description:
            "A location-aware matchmaking and chat application designed for high-engagement social interactions.",
        image:
            // 'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/MeexU/meexu_logo.png',
            'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/MeexU/meexu1.png?updatedAt=1770569033119',
        appIcon:
            'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/MeexU/meexu_logo.png?updatedAt=1770570761649',
        color: AppColors.accent,
        techStack: ["Flutter", "GetX", "Socket.io", "REST APIs", "Firebase"],
        category: 'Client Project',
        responsibilities: [
          "Developed complete UI and state management for mobile app.",
          "Integrated custom backend APIs and real-time messaging.",
          "Implemented user matching algorithms and chat features.",
        ],
        coreFeatures: [
          "Apple, Google and email login",
          "Location-based user discovery (nearby / distance calculation)",
          "Advanced matching logic (interest-based feed and liking system)",
          "Chat with voice, text, image messaging",
          "Match celebration animation & UI",
          "Like, match, and profile sections",
          "Block/unblock system",
          "Google AdMob monetization (Banner, Native, Reward Ads)",
        ],
        appImages: [
          'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/MeexU/meexu1.png?updatedAt=1770569033119',
          'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/MeexU/meexu.png?updatedAt=1770569033131',
        ],
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.tps.meexu&hl=en",
      ),
      ProjectData(
        title: 'Vitals Health Portal',
        description:
            'A unified patient telemetry dashboard bridging wearable device data with clinical backend systems via WebSockets, ensuring zero-latency updates.',
        image: '',
        appIcon: '',
        color: AppColors.primary,
        techStack: [
          "Flutter",
          "HealthKit/GoogleFit",
          "WebSockets",
          "REST APIs",
        ],
        category: 'Personal Project',
        responsibilities: [
          "Designed and built real-time telemetry UI",
          "Integrated wearable device APIs",
          "Implemented WebSocket-based live data streaming",
        ],
        coreFeatures: [
          "Real-time health data visualization",
          "Wearable device integration",
          "Clinical-grade data accuracy",
          "Zero-latency WebSocket updates",
        ],
        appImages: [],
      ),
    ],
    contact: ContactData(
      email: 'agkooo.ako36@gmail.com',
      phone: '+95 9 969 687 330',
      location: 'Mandalay, Myanmar',
      socials: [
        SocialData(
          icon: FontAwesomeIcons.github,
          name: 'GitHub',
          handle: '@kooo12',
          url: 'https://github.com/kooo12',
        ),
        SocialData(
          icon: FontAwesomeIcons.linkedin,
          name: 'LinkedIn',
          handle: 'in/aung-ko-oo',
          url: 'https://www.linkedin.com/in/aung-ko-oo-042342242/',
        ),
        SocialData(
          icon: FontAwesomeIcons.facebook,
          name: 'Facebook',
          handle: '@kooo1210',
          url: 'https://facebook.com/kooo1210',
        ),
        SocialData(
          icon: FontAwesomeIcons.telegram,
          name: 'Telegram',
          handle: '@kooo2109',
          url: 'https://t.me/kooo2109',
        ),
      ],
    ),
  );
}
