import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('App Livres', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) driver.close();
    });

    var textCpf = find.byValueKey('cpf');
    var textSenha = find.byValueKey('senha');

    var button = find.text("Acessar");

    var text = find.text("k");

    test('Efetuar Login', () async {
      await driver.tap(textCpf);
      await Future.delayed(Duration(seconds: 1));
      await driver.enterText("12345678910");
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(textSenha);
      await Future.delayed(Duration(seconds: 1));
      await driver.enterText("root");
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(button);
      await driver.waitFor(text);
      await driver.waitUntilNoTransientCallbacks();
      assert(text != null);
    });

    var buttonPreComunidade = find.byValueKey('PreScreen');
    var buttonFloating = find.byValueKey('floating');
    var nomePre = find.byValueKey('txt_add');
    var buttonAddPre = find.text('Adicionar');
    var res = find.text("Flutter Driver");
    test('Adicionar Pré-Comunidade', () async {
      await driver.tap(buttonPreComunidade);
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(buttonFloating);
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(nomePre);
      await driver.enterText("Flutter Driver");
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(buttonAddPre);
      await Future.delayed(Duration(seconds: 10));
      await driver.waitUntilNoTransientCallbacks();
      await driver.waitFor(res);
      assert(res != null);
    });
  });
}
