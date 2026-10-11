import 'package:cupertino_ui/cupertino_ui.dart';

import '../../design_system/app_theme.dart';
import '../../design_system/components.dart';

class CatalogTokens extends StatelessWidget {
  const CatalogTokens({super.key});
  @override
  Widget build(BuildContext context) {
    final text = AppText.of(context);
    final c = AppColors.of(context);
    final colors = {
      'background': c.background,
      'surface': c.surface,
      'textPrimary': c.text,
      'textSecondary': c.muted,
      'outline': c.outline,
      'accent': c.accent,
      'onAccent': c.onAccent,
      'accentSurface': c.tint,
      'error': c.error,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('색상과 간격', style: text.headlineSmall),
        Wrap(
          spacing: AppSpace.md,
          runSpacing: AppSpace.md,
          children: [
            for (final entry in colors.entries)
              SizedBox(
                width: 160,
                child: GalleryPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 48, color: entry.value),
                      const SizedBox(height: AppSpace.sm),
                      Text(entry.key, style: text.bodyMedium),
                      Text(
                        '#${entry.value.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                        style: text.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        GalleryPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('간격 척도', style: text.titleLarge),
              const SizedBox(height: AppSpace.lg),
              Wrap(
                spacing: AppSpace.lg,
                runSpacing: AppSpace.lg,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  for (final size in [
                    AppSpace.xs,
                    AppSpace.sm,
                    AppSpace.md,
                    AppSpace.lg,
                    AppSpace.xl,
                    AppSpace.xxl,
                  ])
                    Column(
                      children: [
                        Container(width: 32, height: size, color: c.tint),
                        Text('${size.toInt()}'),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        GalleryPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('다음에 만날 것들', style: text.headlineSmall),
              const SizedBox(height: AppSpace.lg),
              Text('관심이 생긴 이유', style: text.titleLarge),
              const SizedBox(height: AppSpace.lg),
              Text('아직 읽지 않은 책의 첫 페이지', style: text.titleMedium),
              const SizedBox(height: AppSpace.lg),
              Text(
                '팟캐스트에서 소개한 관점이 궁금해서 저장했다. 읽은 뒤에는 처음의 기대가 어떻게 달라졌는지 남기고 싶다.',
                style: text.bodyLarge,
              ),
              const SizedBox(height: AppSpace.lg),
              Text('책 · 추천 영상에서 발견', style: text.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
