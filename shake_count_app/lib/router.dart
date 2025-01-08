import 'package:go_router/go_router.dart';
import 'package:shake_count_app/view/board_form_page.dart';
import 'package:shake_count_app/view/board_detail_page.dart';
import 'package:shake_count_app/view/borad_list_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BoardListPage(),
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) => BoardFormPage(),
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BoardFormPage(postId: id);
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