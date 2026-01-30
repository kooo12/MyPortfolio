import 'package:go_router/go_router.dart';
import '../../features/portfolio/presentation/portfolio_view.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const PortfolioView()),
  ],
);
