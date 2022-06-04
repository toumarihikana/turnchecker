import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'tab_wrapper.dart';

class MainContents extends HookConsumerWidget {
  const MainContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const TabWrapWidget();
  }
}
