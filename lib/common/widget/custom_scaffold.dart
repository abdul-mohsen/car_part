import 'package:car_part/common/constant/theme.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    this.titleText = 'Your Title',
    required this.child,
    this.showAppBar = true,
    this.showDrawer = false,
    this.showAppBarActions = false,
    this.enableDarkMode = false,
    this.drawerChild,
    Widget? bottomSheet,
    this.actions,
  })  : _bottomSheet = bottomSheet,
        super(key: key);

  final String titleText;
  final Widget child;
  final bool showAppBar;
  final bool showAppBarActions;
  final bool showDrawer;
  final bool enableDarkMode;
  final Widget? drawerChild;
  final Widget? _bottomSheet;
  final List<Widget>? actions;

  static TextStyle get light => const TextStyle(color: Colors.black);
  static TextStyle get dark => const TextStyle(color: Colors.white);

  List<Widget> get _showActions {
    if (showAppBarActions) {
      return actions ?? [];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    //

    return Theme(
      data: enableDarkMode
          ? ThemeData.dark().copyWith(
              textTheme: ThemeData.dark().textTheme.apply(
                  // fontFamily: Font,
                  ),
            )
          : AppTheme.darkTheme,
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                actions: _showActions,
                title: Text(titleText, style: enableDarkMode ? dark : light),
              )
            : null,
        body: child,
        endDrawer: showDrawer ? drawerChild ?? getDefaultDrawer() : null,
        bottomSheet: _bottomSheet,
      ),
    );
  }

  void _closeEndDrawer() {}

  Drawer getDefaultDrawer() => Drawer(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('This is the Drawer'),
          ElevatedButton(
            onPressed: _closeEndDrawer,
            child: const Text('Close Drawer'),
          ),
        ],
      )));
}
