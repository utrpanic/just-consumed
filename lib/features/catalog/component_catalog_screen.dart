import 'package:cupertino_ui/cupertino_ui.dart';

import '../../design_system/app_theme.dart';
import '../../design_system/components.dart';
import 'catalog_tokens.dart';

/// All current components in one scrollable page, using the actual shared widgets.
class ComponentCatalogScreen extends StatefulWidget {
  const ComponentCatalogScreen({super.key});

  @override
  State<ComponentCatalogScreen> createState() => _ComponentCatalogScreenState();
}

class _ComponentCatalogScreenState extends State<ComponentCatalogScreen> {
  bool? _dark;
  bool _largeText = false;

  @override
  Widget build(BuildContext context) {
    final dark =
        _dark ?? CupertinoTheme.brightnessOf(context) == Brightness.dark;
    final media = MediaQuery.of(context);
    return CupertinoTheme(
      data: dark ? AppTheme.dark : AppTheme.light,
      child: MediaQuery(
        data: media.copyWith(
          textScaler: _largeText
              ? TextScaler.linear(media.textScaler.scale(1) * 1.25)
              : media.textScaler,
        ),
        child: Builder(builder: (context) => _buildCatalog(context, dark)),
      ),
    );
  }

  Widget _buildCatalog(BuildContext context, bool dark) {
    final text = AppText.of(context);
    void demo() => showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('동작 예시'),
        content: const Text('카탈로그의 동작 예시입니다. 기록은 저장하지 않습니다.'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
    final sections = <Widget>[
      const _Example(
        title: '토큰',
        name: 'AppTheme · AppSpace',
        child: CatalogTokens(),
      ),
      _Example(
        title: '버튼',
        name: 'CupertinoButton · filled / tinted / 기본',
        child: Wrap(
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: [
            CupertinoButton.filled(onPressed: demo, child: const Text('저장하기')),
            CupertinoButton.tinted(onPressed: demo, child: const Text('다른 제안')),
            CupertinoButton(onPressed: demo, child: const Text('편집')),
            const CupertinoButton.filled(onPressed: null, child: Text('비활성')),
            const CupertinoButton.tinted(onPressed: null, child: Text('저장 중')),
          ],
        ),
      ),
      const _Example(
        title: '상태 배지',
        name: 'ConsumptionBadge',
        child: Wrap(
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: [
            ConsumptionBadge(consumed: false),
            ConsumptionBadge(consumed: true),
          ],
        ),
      ),
      const _Example(
        title: '필터',
        name: 'CupertinoSlidingSegmentedControl',
        child: _FilterExample(),
      ),
      const _Example(
        title: '입력 필드',
        name: 'RecordField',
        child: Column(
          children: [
            RecordField(
              label: '콘텐츠 제목',
              initialValue: 'Die Empty',
              hint: '목록에서 다시 찾을 수 있는 이름',
            ),
            SizedBox(height: AppSpace.lg),
            RecordField(
              label: '관심이 생긴 이유',
              optional: true,
              lines: 3,
              initialValue: '영상을 보고 원작의 관점이 궁금해져서 저장했다.',
            ),
            SizedBox(height: AppSpace.lg),
            RecordField(
              label: '접근 링크',
              initialValue: 'example',
              error: 'https://로 시작하는 링크를 입력해주세요.',
            ),
          ],
        ),
      ),
      _Example(
        title: '콘텐츠 행',
        name: 'ContentRow',
        child: Column(
          children: [
            ContentRow(
              title: 'Die Empty',
              kind: '책',
              reason: 'Meshing의 관점이 궁금해서 원작도 읽어보고 싶다.',
              icon: CupertinoIcons.book,
              consumed: false,
              onTap: demo,
            ),
            ContentRow(
              title: '긴 한국어 제목과 감상 기록이 있는 콘텐츠도 동일한 목록 구조로 표시합니다',
              kind: '음악',
              reason: '조용히 걷는 시간에 다시 듣고 싶어서. 관심이 생긴 이유가 길어도 목록에서는 두 줄로 요약합니다.',
              icon: CupertinoIcons.headphones,
              consumed: true,
              onTap: demo,
            ),
          ],
        ),
      ),
      _Example(
        title: '추천 카드',
        name: 'RecommendationCard',
        child: RecommendationCard(
          title: '낯선 관점을 만나는 20분',
          metadata: '팟캐스트 · 20분 · will consume',
          reason: '익숙한 방식에서 벗어나 생각하는 이야기가 궁금해서 저장한 콘텐츠입니다.',
          onOpen: demo,
          onAgain: demo,
        ),
      ),
      const _Example(
        title: '패널',
        name: 'GalleryPanel · 기본 / 강조',
        child: Column(
          children: [
            GalleryPanel(child: Text('기록과 입력을 담는 기본 영역')),
            SizedBox(height: AppSpace.lg),
            GalleryPanel(accent: true, child: Text('추천 결과를 강조하는 영역')),
          ],
        ),
      ),
      _Example(
        title: '빈 상태',
        name: '공통 테마로 조합한 상태 예시',
        child: Column(
          children: [
            const Icon(CupertinoIcons.book, size: 32),
            const SizedBox(height: AppSpace.lg),
            Text('아직 저장한 콘텐츠가 없어요', style: text.titleLarge),
            const SizedBox(height: AppSpace.sm),
            const Text('다음에 보고·읽고·듣고 싶은 것을 남겨보세요.'),
            const SizedBox(height: AppSpace.lg),
            CupertinoButton.filled(
              onPressed: demo,
              child: const Text('첫 콘텐츠 기록하기'),
            ),
          ],
        ),
      ),
      _Example(
        title: '오류 · 처리 중',
        name: '공통 테마로 조합한 상태 예시',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('추천을 마치지 못했어요', style: text.titleLarge),
            const SizedBox(height: AppSpace.sm),
            const Text('기록은 그대로 남아 있습니다. 잠시 후 다시 시도해주세요.'),
            const SizedBox(height: AppSpace.sm),
            CupertinoButton.tinted(onPressed: demo, child: const Text('다시 시도')),
            const SizedBox(height: AppSpace.lg),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CupertinoActivityIndicator.partiallyRevealed(
                    progress: .65,
                  ),
                ),
                SizedBox(width: AppSpace.lg),
                Expanded(child: Text('추천 준비 중 · 표시 예시')),
              ],
            ),
          ],
        ),
      ),
    ];
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('컴포넌트 카탈로그')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpace.lg),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('작성된 컴포넌트 모아보기', style: text.headlineSmall),
                  const SizedBox(height: AppSpace.sm),
                  Text(
                    '실제 공통 위젯과 테마를 사용합니다. 샘플 입력과 버튼 동작은 저장되지 않습니다.',
                    style: text.bodyMedium,
                  ),
                  const SizedBox(height: AppSpace.lg),
                  Wrap(
                    spacing: AppSpace.sm,
                    runSpacing: AppSpace.sm,
                    children: [
                      CupertinoButton(
                        onPressed: () => setState(() => _dark = !dark),
                        child: Text(dark ? '라이트 테마' : '다크 테마'),
                      ),
                      CupertinoButton.tinted(
                        onPressed: () =>
                            setState(() => _largeText = !_largeText),
                        child: Text(_largeText ? '기본 글자' : '글자 확대'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpace.xl),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 760;
                      final width = wide
                          ? (constraints.maxWidth - AppSpace.lg) / 2
                          : constraints.maxWidth;
                      return Wrap(
                        spacing: AppSpace.lg,
                        runSpacing: AppSpace.lg,
                        children: [
                          for (final section in sections)
                            SizedBox(width: width, child: section),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Example extends StatelessWidget {
  const _Example({
    required this.title,
    required this.name,
    required this.child,
  });
  final String title, name;
  final Widget child;
  @override
  Widget build(BuildContext context) => GalleryPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: AppText.of(context).titleLarge),
        const SizedBox(height: AppSpace.xs),
        Text(name, style: AppText.of(context).labelSmall),
        const SizedBox(height: AppSpace.lg),
        child,
      ],
    ),
  );
}

class _FilterExample extends StatefulWidget {
  const _FilterExample();
  @override
  State<_FilterExample> createState() => _FilterExampleState();
}

class _FilterExampleState extends State<_FilterExample> {
  String _selected = '전체';
  @override
  Widget build(BuildContext context) =>
      CupertinoSlidingSegmentedControl<String>(
        groupValue: _selected,
        children: {
          for (final label in ['전체', 'will consume', 'consumed'])
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
              child: Text(
                label,
                style: AppText.of(context).labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
        },
        onValueChanged: (value) {
          if (value != null) setState(() => _selected = value);
        },
      );
}
