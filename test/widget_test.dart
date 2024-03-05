// This is a Flutter widget test that checks whether the 'Counter' widget
// correctly increments its value when the user taps the '+' icon.
//
// Widget tests are a type of test in Flutter that allow you to simulate user
// interactions with your app and verify that the UI updates correctly. In this
// test, we are using the 'testWidgets' function provided by the
// 'flutter_test' package to define our test case.
//
// The first thing we do in this test is build our app using the 'pumpWidget'
// method provided by the 'WidgetTester' utility. This method takes a widget
// and builds it on the screen, triggering a frame.
//
// Once our app is built, we can use the 'find' utility provided by
// 'WidgetTester' to find widgets in the widget tree. In this test, we are
// using 'find.text' to find the text displaying the current value of the
// counter.
//
// We then use the 'expect' function to verify that the counter starts at 0.
// The 'expect' function takes an expected value and a finder, and checks that
// the finder matches the expected value. In this case, we are checking that
// the text '0' appears exactly once on the screen.
//
// Next, we simulate a user tap on the '+' icon using the 'tap' method provided
// by 'WidgetTester'. This method takes a finder and simulates a tap gesture on
// the first widget that matches the finder.
//
// After simulating the tap, we use 'pump' to advance the animation and layout
// frames. This ensures that any UI updates triggered by the tap are reflected
// on the screen.
//
// Finally, we use 'expect' again to verify that the counter has incremented.
// We check that the text '0' no longer appears on the screen, and that the
// text '1' appears exactly once.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test
