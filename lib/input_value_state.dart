// @riverpod アノテーションは `riverpod_annotation` をインポートして使います
import 'package:riverpod_annotation/riverpod_annotation.dart';

// コード生成を実行するために、 `part '{ファイル名}.g.dart';` を忘れずに書きましょう
part 'input_value_state.g.dart';

@riverpod
class InputValue extends _$InputValue {
  @override
  String build() => '0';

  void set(String sewState) => state = sewState;
}
