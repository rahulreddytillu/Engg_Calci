
import 'dart:ui';

//import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
void main(){
  runApp(TestApp());
}

const List<String> menuItems = <String>['one', 'two', 'three', 'four'];
final ValueChanged<String> onChanged = (_) { };

final Type dropdownButtonType = DropdownButton<String>(
  onChanged: (_) { },
  items: const <DropdownMenuItem<String>>[],
).runtimeType;

//Finder _iconRichText(Key iconKey) {
//  return find.descendant(
//    of: find.byKey(iconKey),
//    matching: find.byType(RichText),
//  );
//}

Widget buildFrame({
  Key buttonKey,
  String value = 'two',
  ValueChanged<String> onChanged,
  Widget icon,
  Color iconDisabledColor,
  Color iconEnabledColor,
  double iconSize = 24.0,
  bool isDense = false,
  bool isExpanded = false,
  Widget hint,
  Widget disabledHint,
  Widget underline,
  List<String> items = menuItems,
  Alignment alignment = Alignment.center,
  TextDirection textDirection = TextDirection.ltr,
}) {
  return TestApp(
    textDirection: textDirection,
    child: Material(
      child: Align(
        alignment: alignment,
        child: RepaintBoundary(
          child: DropdownButton<String>(
            key: buttonKey,
            value: value,
            hint: hint,
            disabledHint: disabledHint,
            onChanged: onChanged,
            icon: icon,
            iconSize: iconSize,
            iconDisabledColor: iconDisabledColor,
            iconEnabledColor: iconEnabledColor,
            isDense: isDense,
            isExpanded: isExpanded,
            underline: underline,
            items: items == null ? null : items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                key: ValueKey<String>(item),
                value: item,
                child: Text(item, key: ValueKey<String>(item + 'Text')),
              );
            }).toList(),
          ),
        ),
      ),
    ),
  );
}

class TestApp extends StatefulWidget {
  const TestApp({ this.textDirection, this.child });
  final bool TextDirection; textDirection=true;
  final Widget child;
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: MediaQuery(
        data: MediaQueryData.fromWindow(window),
        child: Directionality(
          textDirection: widget.textDirection,
          child: Navigator(
            onGenerateRoute: (RouteSettings settings) {
              assert(settings.name == '/');
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (BuildContext context) => widget.child,
              );
            },
          ),
        ),
      ),
    );
  }
}