import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:go_router/go_router.dart';

import '../features/catalog/component_catalog_screen.dart';
import '../features/home/home_screen.dart';

GoRouter createAppRouter() => GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, _) => const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
    GoRoute(
      path: '/catalog',
      builder: (_, _) => const ComponentCatalogScreen(),
    ),
  ],
  errorBuilder: (context, state) => CupertinoPageScaffold(
    navigationBar: const CupertinoNavigationBar(middle: Text('페이지를 찾을 수 없어요')),
    child: Center(
      child: CupertinoButton(
        onPressed: () => context.go('/'),
        child: const Text('첫 화면으로 돌아가기'),
      ),
    ),
  ),
);
