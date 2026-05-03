import 'package:flutter_test/flutter_test.dart';
import 'package:wear_well_app/main.dart';

void main() {
  testWidgets('App starts with splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const WearWellApp());
    expect(find.text('WEAR-WELL'), findsOneWidget);
  });
}