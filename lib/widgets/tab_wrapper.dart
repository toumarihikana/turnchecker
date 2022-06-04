import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/tab_index_provider.dart';
import 'each_checklist.dart';
import '../providers/profile_provider.dart';

class TabWrapWidget extends HookConsumerWidget {
  const TabWrapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = <Tab>[
      const Tab(text: 'myself', icon: Icon(Icons.person)),
      const Tab(text: 'opponent', icon: Icon(Icons.person_outline))
    ];

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color tabColor = colorScheme.background;
    final Color tabTextColor = colorScheme.onSurface;

    final controller = useTabController(initialLength: tabs.length);

    useEffectOnce(() {
      controller.addListener(() {
        changeTab(ref, controller.index);
      });
      return null;
    });

    return Column(
      children: <Widget>[
        Ink(
          color: tabColor,
          child: TabBar(
            controller: controller,
            tabs: tabs,
            labelColor: tabTextColor,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              EachChecklist(targetProvider: myProfileProvider),
              EachChecklist(targetProvider: opponentProfileProvider),
            ],
          ),
        ),
      ],
    );
  }

  void changeTab(WidgetRef ref, int index) {
    ref.read(tabIndexProvider.notifier).changeTabIndex(index);
  }
}
