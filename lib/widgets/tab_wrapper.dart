import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/tab_index_provider.dart';
import 'each_checklist.dart';
import '../providers/profile_provider.dart';

class TabWrapWidget extends HookConsumerWidget {
  TabWrapWidget({Key? key}) : super(key: key);
  final tabs = <Tab>[
    const Tab(text: 'myself', icon: Icon(Icons.person)),
    const Tab(text: 'opponent', icon: Icon(Icons.person_outline))
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTabController(initialLength: tabs.length);

    final myProfile = ref.watch(myProfileProvider);
    final opponentProfile = ref.watch(opponentProfileProvider);

    useEffectOnce(() {
      controller.addListener(() {
        changeTab(ref, controller.index);
      });
      return null;
    });

    return Column(
      children: <Widget>[
        Ink(
          color: Colors.blue,
          child: TabBar(
            controller: controller,
            tabs: tabs,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              EachChecklist(profile: myProfile),
              EachChecklist(profile: opponentProfile),
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