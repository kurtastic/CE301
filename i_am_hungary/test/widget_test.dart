// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:i_am_hungary/screens/welcome_screen.dart';

void main() {
  testWidgets('Intro Screen test', (WidgetTester tester) async {
    final hungryAppBar = find.byKey(ValueKey("hungryAppBar"));
    final menuBottom = find.byKey(ValueKey('menuBottom'));
    final image = find.byKey(ValueKey('image'));
    final welcomeMessage = find.byKey(ValueKey('welcomeMessage'));
    // Verify that our counter starts at 0.
    await tester.pumpWidget(MaterialApp(home: IntroScreen()));

    expect(
        find.text(
          'Lets help tackle climate change and foodwaste by sharing Food\n\nClick Map to start\n↓',
        ),
        findsOneWidget);

    expect(hungryAppBar, findsOneWidget);
    expect(menuBottom, findsOneWidget);
    expect(image, findsOneWidget);
    expect(welcomeMessage, findsOneWidget);


  });

  // testWidgets('Login Screen Test', (WidgetTester tester)async{
  //     Mongo_db database = await Mongo_db().initConnection();

  //       //final loginAppBar = find.byKey(ValueKey("loginAppBar"));
  //       final usernameTextfield = find.byKey(ValueKey('usernameTextfield'));
  //       //final passwordTextfield = find.byKey(ValueKey('passwordTextfield'));
  //      // final loginButton = find.byKey(ValueKey('loginButton'));

  //      await tester.pumpWidget(MaterialApp(home: Login( database)));
  //      // expect(passwordTextfield, findsOneWidget);
  //       //expect(usernameTextfield, findsOneWidget);
  //       tester.enterText(usernameTextfield, 'paul');
  //      // tester.pump();
  //       //tester.enterText(passwordTextfield, '1234');

  //       expect(find.text('paul'), findsOneWidget);
  //     //  tester.tap(loginButton);
        
  //      // tester.pump();

  //      // expect(find.byWidget(IntroScreen()), findsOneWidget);




  // } );


  // test("mongoDb test", ()async{
  //     Mongo_db database = await Mongo_db().initConnection();
  //     final String _host =
  //     "mongodb+srv://admin:admin@imhungary.sdot6.mongodb.net/community?retryWrites=true&w=majority";
  //     Db db = await database.getDb().open();
  //     expect(await database.getDb(),db);





  // });


  

}
