import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculadora_imc/main.dart';

void main() {
  testWidgets('Teste da calculadora de IMC', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Informe seus dados:'), findsOneWidget);

    // Simula o preenchimento dos campos
    await tester.enterText(find.byType(TextFormField).at(0), 'João');
    await tester.enterText(find.byType(TextFormField).at(1), '70');
    await tester.enterText(find.byType(TextFormField).at(2), '1.75');

    // Clica no botão de calcular IMC
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verifica se o resultado do IMC é exibido
    expect(find.text('Seu IMC é: 22.86'), findsOneWidget);
  });
}
