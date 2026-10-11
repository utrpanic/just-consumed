import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:go_router/go_router.dart';

import '../routing/app_router.dart';

class JustConsumedApp extends StatefulWidget {
  const JustConsumedApp({super.key});
  @override
  State<JustConsumedApp> createState() => _JustConsumedAppState();
}

class _JustConsumedAppState extends State<JustConsumedApp> {
  late final GoRouter _router = createAppRouter();
  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      CupertinoApp.router(title: 'Flutter Demo', routerConfig: _router);
}
