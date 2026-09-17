import 'package:go_router/go_router.dart';

import '../../features/post/presentation/screens/post_create_screen.dart';
import '../../features/post/presentation/screens/post_fetch_screen.dart';

abstract class AppRouter {
  static final routes = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'posts',
        builder: (context, state) => const PostFetchScreen(),
      ),
      GoRoute(
        path: '/posts-create',
        name: 'posts-create',
        builder: (context, state) => const PostCreateScreen(),
      ),
    ],
  );
}
