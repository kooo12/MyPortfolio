import '../../domain/models/portfolio_models.dart';
import '../../../../core/theme/app_colors.dart';

class PortfolioRepository {
  static const PortfolioData data = PortfolioData(
    hero: HeroData(
      title: 'HI, I AM AUNG KO OO',
      subtitle: 'Flutter Developer\nCrafting Premium\nExperiences.',
      description: '3+ Years Experience | Tech Plus Solutions (TPS)',
      profileImg: 'assets/profile.png',
    ),
    about: AboutData(
      title: 'ABOUT ME',
      bio1:
          'Passionate Flutter developer with a focus on creating premium, user-centric experiences. With over 3 years of professional experience, I have developed a deep understanding of mobile architecture, performance optimization, and clean code principles.',
      bio2:
          'I believe that great software is more than just code; it\'s about crafting intuitive interactions and beautiful interfaces that solve real-world problems. My journey in tech is driven by continuous learning and a desire to build tools that empower users.',
      tags: [
        'Based in Yangon, MM',
        'Full-time / Freelance',
        'Available for Projects',
      ],
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
        description:
            'Driving high-performance mobile solutions. Specialized in complex architectural patterns and performance profiling.',
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
            "Started career as Flutter developer, learning on various mobile projects and best practices.",
        companyLogo:
            "data:image/jpeg;base64,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",

        achievements: [
          "Developed first commercial mobile application",
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
        title: 'Sonus Music Player',
        description:
            "A music player app with a modern glamorous UI and smooth animations. Features smooth animations and offline support. It supports mp3, wav, m4a, and other audio formats.",
        image:
            'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/SONUSMusicPlayer/sonus_logo.png?updatedAt=1770569033141',
        color: AppColors.primary,
        techStack: [
          "Flutter",
          "Firebase",
          "GetX",
          "SQLite",
          "Audio Engine",
          "Animations",
          "Firebase FCM",
          "Firebase Firestore",
        ],
        category: 'Mobile',
        responsibilities: [
          "Developed complete UI and state management for mobile app.",
          "Integrated Firebase Firestore Database for fcm tokens.",
          "Implemented admin access for push notifications, manage users and fcm tokens",
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
          'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/SONUSMusicPlayer/sonus_logo.png?updatedAt=1770569033141',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.ako.sonus',
        githubUrl: 'https://github.com/kooo12/sonus',
      ),
      ProjectData(
        title: 'Htun Pauk Fuel Energy & Logistics Management System',
        description:
            "A comprehensive fuel management system for logistics companies, featuring real-time tracking, automated reporting, and driver management. Built with Flutter for cross-platform support.A full-stack logistics and fuel distribution platform for businesses and transportation fleets",
        image:
            'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/HtunPauk/htunpauk_store_icon-2.png',
        color: AppColors.primary,
        techStack: [
          "Flutter",
          "GetX",
          "Provider",
          "REST APIs",
          "Firebase",
          "Firebase FCM",
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
            'https://ik.imagekit.io/aungkooo/PortfolioProjectImages/MeexU/meexu_logo.png',
        color: AppColors.accent,
        techStack: [
          "Flutter",
          "GetX",
          "Socket.io",
          "REST APIs",
          "Firebase FCM",
        ],
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
    ],
  );
}
