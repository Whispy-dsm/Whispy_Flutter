import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhispyScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;

  const WhispyScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
