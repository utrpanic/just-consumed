import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
    child: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: CupertinoTheme.of(context)
                  .textTheme
                  .navLargeTitleTextStyle,
            ),
            CupertinoButton(
              onPressed: () => setState(() => _counter++),
              child: Semantics(
                label: 'Increment',
                child: const Icon(CupertinoIcons.add),
              ),
            ),
            CupertinoButton(
              onPressed: () => context.push('/catalog'),
              child: const Text('디자인 시스템 카탈로그 열기'),
            ),
          ],
        ),
      ),
    ),
  );
}
