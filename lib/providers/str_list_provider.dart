import 'package:hooks_riverpod/hooks_riverpod.dart';

class StrListNotifier extends StateNotifier<List<String>> {
  StrListNotifier() : super(['0']);

  void add({String str = 'a'}) {
    state = [...state, str];
  }
}

final strListProvider = StateNotifierProvider<StrListNotifier, List<String>>(
    (_) => StrListNotifier());
