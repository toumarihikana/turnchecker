import 'package:hooks_riverpod/hooks_riverpod.dart';

class Count extends StateNotifier<int> {
  Count() : super(0);

  void increment() => state++;
}

final countProvider = StateNotifierProvider<Count, int>((_) => Count());
