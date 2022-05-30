import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/count_provider.dart';
import 'bottom_app_bar.dart';
import 'increment_button.dart';
import 'main_contets.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turn Checker'),
      ),
      body: const SafeArea(
        child: MainContents(),
      ),
      floatingActionButton: const IncrementButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: BottomBar(
        stateCheckStr: ref.watch(countProvider).toString(),
      ),
    );
  }
}
