import 'package:flutter_test/flutter_test.dart';
import 'package:math_radar/app.dart';

void main() {
  testWidgets('MathRadar ana ekrani acilir', (tester) async {
    await tester.pumpWidget(const MathRadarApp(backendEnabled: false));
    expect(find.text('MathRadar'), findsOneWidget);
    expect(find.text('Ogretmen Paneli'), findsOneWidget);
  });
}
