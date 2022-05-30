import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/flat_model.dart';

class FlatModelNotifier extends StateNotifier<FlatModel> {
  FlatModelNotifier(int id, String name)
      : super(FlatModel(id: id, name: name, isCheck: false));

  void changeModel(String name) {
    state = FlatModel(id: ++state.id, name: name, isCheck: false);
  }
}

typedef FlatModelProvider = StateNotifierProvider<FlatModelNotifier, FlatModel>;

final flatModelrovider =
    FlatModelProvider((ref) => FlatModelNotifier(0, 'ku-haku'));
