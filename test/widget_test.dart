import 'package:flutter_test/flutter_test.dart';
import 'package:fitflow/main.dart';

void main() {
  testWidgets('FitFlow app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FitFlowApp());

    // Verify that FitFlow loads correctly
    expect(find.text('AI DAILY FLOW'), findsOneWidget);
  });
}
