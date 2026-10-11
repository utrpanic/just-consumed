import 'package:cupertino_ui/cupertino_ui.dart';

import 'app_theme.dart';

class GalleryPanel extends StatelessWidget {
  const GalleryPanel({super.key, required this.child, this.accent = false});
  final Widget child;
  final bool accent;
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpace.xl),
      decoration: BoxDecoration(
        color: accent ? colors.tint : colors.surface,
        border: Border.all(color: colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class ConsumptionBadge extends StatelessWidget {
  const ConsumptionBadge({super.key, required this.consumed});
  final bool consumed;
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: consumed ? colors.tint : AppColors.of(context).background,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        consumed ? 'consumed' : 'will consume',
        style: AppText.of(context).labelSmall
            .copyWith(color: consumed ? colors.accent : colors.muted),
      ),
    );
  }
}

class ContentRow extends StatelessWidget {
  const ContentRow({
    super.key,
    required this.title,
    required this.kind,
    required this.reason,
    required this.icon,
    required this.consumed,
    required this.onTap,
  });
  final String title, kind, reason;
  final IconData icon;
  final bool consumed;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final text = AppText.of(context);
    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpace.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 64,
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 24, color: colors.muted),
                ),
                const SizedBox(width: AppSpace.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: text.titleMedium,
                      ),
                      const SizedBox(height: AppSpace.xs),
                      Wrap(
                        spacing: AppSpace.sm,
                        runSpacing: AppSpace.xs,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(kind, style: text.bodyMedium),
                          ConsumptionBadge(consumed: consumed),
                        ],
                      ),
                      const SizedBox(height: AppSpace.sm),
                      Text(
                        reason,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(height: 1, color: colors.outline),
      ],
    );
  }
}

class RecordField extends StatefulWidget {
  const RecordField({
    super.key,
    required this.label,
    this.initialValue,
    this.optional = false,
    this.lines = 1,
    this.error,
    this.hint,
  });
  final String label;
  final String? initialValue, error, hint;
  final bool optional;
  final int lines;
  @override
  State<RecordField> createState() => _RecordFieldState();
}

class _RecordFieldState extends State<RecordField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.optional ? '${widget.label} · 선택' : widget.label,
        style: AppText.of(context).labelLarge,
      ),
      const SizedBox(height: AppSpace.sm),
      Semantics(
        label: widget.label,
        child: CupertinoTextField(
          controller: _controller,
          minLines: widget.lines,
          maxLines: widget.lines == 1 ? 1 : null,
        ),
      ),
      if (widget.error != null || widget.hint != null) ...[
        const SizedBox(height: AppSpace.xs),
        Text(
          widget.error ?? widget.hint!,
          style: AppText.of(context).bodyMedium.copyWith(
            color: widget.error != null
                ? AppColors.of(context).error
                : AppColors.of(context).muted,
          ),
        ),
      ],
    ],
  );
}

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.title,
    required this.metadata,
    required this.reason,
    required this.onOpen,
    required this.onAgain,
  });
  final String title, metadata, reason;
  final VoidCallback onOpen, onAgain;
  @override
  Widget build(BuildContext context) {
    final text = AppText.of(context);
    return GalleryPanel(
      accent: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('YOUR NEXT · 데모 추천', style: text.labelSmall),
          const SizedBox(height: AppSpace.md),
          Text(title, style: text.titleLarge),
          const SizedBox(height: AppSpace.sm),
          Text(metadata, style: text.bodyMedium),
          const SizedBox(height: AppSpace.lg),
          Text(reason, style: text.bodyLarge),
          const SizedBox(height: AppSpace.lg),
          Wrap(
            spacing: AppSpace.sm,
            runSpacing: AppSpace.sm,
            children: [
              CupertinoButton.filled(
                onPressed: onOpen,
                child: const Text('기록 보기'),
              ),
              CupertinoButton.tinted(
                onPressed: onAgain,
                child: const Text('다른 제안'),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.lg),
          Text(
            'AI를 호출하지 않는 데모입니다. 접근 링크가 없어 기록을 먼저 보여줍니다.',
            style: text.bodyMedium,
          ),
        ],
      ),
    );
  }
}
