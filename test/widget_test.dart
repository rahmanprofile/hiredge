import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobkar_pro/main.dart';
import 'package:jobkar_pro/view/navigation/navigation_home.dart';

void main() {
  testWidgets("Flutter test widget", (widgetTester) async {
    await widgetTester.pumpWidget(MyApp());
    var status = find.byWidget(MaterialApp());
    expect(status, NavigationHome());
  });
}