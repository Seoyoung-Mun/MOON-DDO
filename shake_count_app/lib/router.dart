import 'package:go_router/go_router.dart';
import 'package:shake_count_app/view/board_create_page.dart';
import 'package:shake_count_app/view/boardr_detail_page.dart';
import 'package:shake_count_app/view/borad_list_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BoardListPage(),
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) => BoardCreatePage(),
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BoardCreatePage(postId: id);
      },
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BoardDetailPage(postId: id);
      },
    ),
  ],
);