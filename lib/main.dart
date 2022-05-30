import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'platforms/export/url_strategy_export.dart';
import 'widgets/main_page.dart';

void main() {
  commonSetUrlStrategy();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final FutureProvider initialProvider = FutureProvider((ref) async {
  // await Dao().initialize();
  // final packageInfo = ref.read(ConfigProvider.packageInfoProvider).value;
  // var config = await Dao().config();
  // if (config != null) {
  //   ref.read(ConfigProvider.configProvider.notifier).state = config;
  // }
});

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var initial = ref.watch(initialProvider);
    return initial.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) {
        return Center(child: Text("$err \n Chrome plz!"));
      },
      data: (config) {
        // var themeModeValue = ref.watch(
        //     ConfigProvider.configProvider.select((value) => value.themeMode));
        var themeData = ThemeData(
          // textTheme: kIsWeb
          //     ? GoogleFonts.sawarabiGothicTextTheme(Theme.of(context).textTheme)
          //     : null,
          primarySwatch: Colors.purple,
        );
        return MaterialApp(
          title: "Turn Checker",
          theme: themeData,
          darkTheme: ThemeData.dark(),
          // themeMode: themeModeValue,
          debugShowCheckedModeBanner: false,
          home: const MainPage(),
        );
      },
    );
  }
}
