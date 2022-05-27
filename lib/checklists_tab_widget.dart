import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'check_list_page.dart';
import 'common_checklists_widget.dart';
import 'profile_provider.dart';

class ChecklistsTabWidget extends ConsumerStatefulWidget {
  const ChecklistsTabWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ChecklistsTabWidgetState();
}

class ChecklistsTabWidgetState extends ConsumerState<ChecklistsTabWidget>
    with SingleTickerProviderStateMixin {
  final tabs = <Tab>[
    const Tab(text: 'myself', icon: Icon(Icons.person)),
    const Tab(text: 'opponent', icon: Icon(Icons.person_outline))
  ];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Ink(
          color: Colors.blue,
          child: TabBar(
            tabs: tabs,
            controller: tabController,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            onTap: (tabIndex) {
              if (tabIndex == 1) {
                ref.watch(nowProfileNameProvider.notifier).changeProfileName(
                    ref.watch(opponentDisplayProfileProvider).name!);

                nowDisplayProfileProvider = opponentDisplayProfileProvider;
                nowDisplayProfileNotifier = OpponentDisplayProfileNotifier();
              } else {
                ref.watch(nowProfileNameProvider.notifier).changeProfileName(
                    ref.watch(myDisplayProfileProvider).name!);
                nowDisplayProfileProvider = myDisplayProfileProvider;
                nowDisplayProfileNotifier = MyDisplayProfileNotifier();
              }
            },
          ),
        ),
        Expanded(
            child: TabBarView(controller: tabController, children: [
          CommonChecklistsWidget(myDisplayProfileProvider),
          CommonChecklistsWidget(opponentDisplayProfileProvider)
        ]))
      ],
    );
  }
}
