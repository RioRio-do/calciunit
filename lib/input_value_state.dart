import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input_value_state.g.dart';

@riverpod
class InputValue extends _$InputValue {
  @override
  String build() => '1';

  void set(String sewState) => state = sewState;
}
