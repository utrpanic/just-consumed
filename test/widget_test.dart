import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:just_consumed/app/app.dart';
import 'package:just_consumed/design_system/app_theme.dart';
import 'package:just_consumed/features/catalog/component_catalog_screen.dart';

void main() {
  for (final platform in [TargetPlatform.iOS, TargetPlatform.android]) {
    testWidgets('default Cupertino navigation on $platform', (tester) async {
      await tester.pumpWidget(const JustConsumedApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text('디자인 시스템 카탈로그 열기'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      final context = tester.element(find.byType(ComponentCatalogScreen));
      final route = ModalRoute.of(context)!;
      expect(route.settings, isA<CupertinoPage>());
      expect(route.animation!.value, greaterThan(0));
      expect(route.animation!.value, lessThan(1));
      expect(find.byType(CupertinoPageTransition), findsWidgets);
      await tester.pumpAndSettle();
      await tester.dragFrom(const Offset(1, 300), const Offset(700, 0));
      await tester.pumpAndSettle();
      expect(find.byType(ComponentCatalogScreen), findsNothing);
      expect(find.text('Flutter Demo Home Page'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }, variant: TargetPlatformVariant({platform}));
  }

  testWidgets(
    'template counter opens independent catalog and returns unchanged',
    (tester) async {
      await tester.pumpWidget(const JustConsumedApp());
      await tester.pumpAndSettle();
      expect(find.text('Flutter Demo Home Page'), findsOneWidget);
      expect(
        find.text('You have pushed the button this many times:'),
        findsOneWidget,
      );
      expect(find.text('0'), findsOneWidget);
      expect(find.byType(ComponentCatalogScreen), findsNothing);
      expect(find.text('다음에 만날 것들'), findsNothing);
      expect(find.text('Surprise me'), findsNothing);
      await tester.tap(
        find.widgetWithIcon(CupertinoButton, CupertinoIcons.add),
      );
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
      await tester.tap(find.text('디자인 시스템 카탈로그 열기'));
      await tester.pumpAndSettle();
      final context = tester.element(find.byType(ComponentCatalogScreen));
      expect(GoRouterState.of(context).uri.path, '/catalog');
      for (final name in [
        'ConsumptionBadge',
        'RecordField',
        'ContentRow',
        'RecommendationCard',
      ]) {
        expect(find.text(name), findsOneWidget);
      }
      await tester.tap(find.byType(CupertinoNavigationBarBackButton));
      await tester.pumpAndSettle();
      expect(find.text('Flutter Demo Home Page'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    },
  );

  testWidgets(
    'catalog works without app providers or router on a narrow screen',
    (tester) async {
      tester.view.physicalSize = const Size(320, 740);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        CupertinoApp(
          theme: AppTheme.light,
          home: const ComponentCatalogScreen(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('다크 테마'));
      await tester.pumpAndSettle();
      expect(
        CupertinoTheme.of(tester.element(find.text('라이트 테마'))).brightness,
        Brightness.dark,
      );
      await tester.tap(find.text('글자 확대'));
      await tester.pumpAndSettle();
      expect(find.text('기본 글자'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('오류 · 처리 중'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final action = find.text('기록 보기');
      await tester.ensureVisible(action);
      await tester.tap(action);
      await tester.pumpAndSettle();
      expect(find.text('카탈로그의 동작 예시입니다. 기록은 저장하지 않습니다.'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
