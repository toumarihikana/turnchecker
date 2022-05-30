import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabIndexNotifier extends StateNotifier<int> {
  TabIndexNotifier() : super(0);

  void changeTabIndex(int index) {
    state = index;
  }
}

typedef TabIndexProvider = StateNotifierProvider<TabIndexNotifier, int>;

final tabIndexProvider = TabIndexProvider((_) => TabIndexNotifier());
