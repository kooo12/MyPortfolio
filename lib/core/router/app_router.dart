import 'package:go_router/go_router.dart';
import '../../features/portfolio/presentation/portfolio_view.dart';
import '../../features/portfolio/presentation/screens/project_details_screen.dart';
import '../../features/portfolio/presentation/screens/image_viewer_screen.dart';
import '../../features/portfolio/domain/models/portfolio_models.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const PortfolioView()),
    GoRoute(
      path: '/project-details',
      builder: (context, state) {
        final project = state.extra as ProjectData;
        return ProjectDetailsScreen(project: project);
      },
    ),
    GoRoute(
      path: '/image-viewer',
      builder: (context, state) {
        final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
        return ImageViewerScreen(
          images: args['images'] as List<String>,
          initialIndex: args['initialIndex'] as int,
          heroTagPrefix: args['heroTagPrefix'] as String,
        );
      },
    ),
  ],
);
