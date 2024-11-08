// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:calciunit/deck_dialog.dart';
import 'package:calciunit/logic/data.dart';

void main() {
  group('DeckDialog Widget Tests', () {
    late ProviderContainer container;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    Widget createWidgetUnderTest(Widget child) {
      return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(body: child),
          ),
        ),
      );
    }

    testWidgets('ダイアログの基本的なUIテスト', (WidgetTester tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          DeckDialog(
            selectedItems: const {0, 1},
            unitData: Units.values[0].data,
            unitId: 0,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('デッキを保存'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('キャンセル'), findsOneWidget);
      expect(find.text('保存'), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('空のデッキ名でエラー表示', (WidgetTester tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          DeckDialog(
            selectedItems: const {0},
            unitData: Units.values[0].data,
            unitId: 0,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(find.text('デッキ名を入力してください'), findsOneWidget);
    });

    testWidgets('キャンセルボタンでダイアログが閉じる', (WidgetTester tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          DeckDialog(
            selectedItems: const {0},
            unitData: Units.values[0].data,
            unitId: 0,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('キャンセル'));
      await tester.pumpAndSettle();

      expect(find.byType(DeckDialog), findsNothing);
    });

    testWidgets('デッキ名入力後に保存可能', (WidgetTester tester) async {
      // Navigatorを持つルートを作成
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              home: Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: DeckDialog(
                        selectedItems: const {0},
                        unitData: Units.values[0].data,
                        unitId: 0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // テキストフィールドにフォーカスを設定
      final textField = find.byType(TextField);
      await tester.tap(textField);
      await tester.pumpAndSettle();

      // テキスト入力
      await tester.enterText(textField, 'テストデッキ');
      await tester.pumpAndSettle();

      expect(find.text('デッキ名を入力してください'), findsNothing);

      // 保存ボタンをタップ
      await tester.tap(find.text('保存'));

      // ダイアログが閉じるのを待つ
      await tester.pump(); // アニメーション開始
      await tester.pump(const Duration(seconds: 1)); // アニメーション完了まで待機

      // ダイアログが閉じていることを確認
      expect(find.byType(DeckDialog), findsNothing);

      // SharedPreferencesの状態を確認
      final prefs = await SharedPreferences.getInstance();
      final decksJson = prefs.getString('unitsDecks');
      expect(decksJson, isNotNull);
      expect(decksJson, contains('テストデッキ'));
    });
  });
}
