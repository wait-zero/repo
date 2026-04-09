import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:waitzero/main.dart';

void main() {
  testWidgets('App renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: WaitZeroApp()));
    await tester.pump();
    expect(find.text('WaitZero'), findsOneWidget);
  });
}
