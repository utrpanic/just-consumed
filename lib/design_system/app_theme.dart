import 'package:cupertino_ui/cupertino_ui.dart';

abstract final class AppSpace {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

abstract final class AppTheme {
  static const light = CupertinoThemeData(brightness: Brightness.light);
  static const dark = CupertinoThemeData(brightness: Brightness.dark);
}

/// Semantic colors resolved from Cupertino's dynamic system colors.
class AppColors {
  AppColors.of(BuildContext context)
    : background = CupertinoTheme.of(context).scaffoldBackgroundColor,
      surface = CupertinoColors.secondarySystemGroupedBackground.resolveFrom(
        context,
      ),
      text = CupertinoColors.label.resolveFrom(context),
      muted = CupertinoColors.secondaryLabel.resolveFrom(context),
      outline = CupertinoColors.separator.resolveFrom(context),
      accent = CupertinoTheme.of(context).primaryColor,
      onAccent = CupertinoTheme.of(context).primaryContrastingColor,
      tint = CupertinoTheme.of(context).primaryColor.withValues(alpha: .12),
      error = CupertinoColors.systemRed.resolveFrom(context);

  final Color background,
      surface,
      text,
      muted,
      outline,
      accent,
      onAccent,
      tint,
      error;
}

/// App content typography; navigation and controls retain Cupertino defaults.
class AppText {
  AppText.of(BuildContext context)
    : _base = CupertinoTheme.of(context).textTheme.textStyle,
      _colors = AppColors.of(context);

  final TextStyle _base;
  final AppColors _colors;
  TextStyle _style(double size, FontWeight weight, [Color? color]) =>
      _base.copyWith(
        fontSize: size,
        fontWeight: weight,
        height: 1.5,
        color: color ?? _colors.text,
      );
  TextStyle get headlineSmall => _style(24, FontWeight.w600);
  TextStyle get titleLarge => _style(18, FontWeight.w600);
  TextStyle get titleMedium => _style(16, FontWeight.w600);
  TextStyle get bodyLarge => _style(16, FontWeight.w400);
  TextStyle get bodyMedium => _style(14, FontWeight.w400, _colors.muted);
  TextStyle get labelLarge => _style(14, FontWeight.w600);
  TextStyle get labelSmall => _style(12, FontWeight.w400, _colors.muted);
}
