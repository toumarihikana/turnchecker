import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/count_provider.dart';
import 'tab_wrapper.dart';

class MainContents extends HookConsumerWidget {
  const MainContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useState(0);

    final counter = ref.watch(countProvider);
    return TabWrapWidget();
  }
}
