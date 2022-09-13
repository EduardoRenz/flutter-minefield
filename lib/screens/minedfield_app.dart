import 'package:flutter/material.dart';
import 'package:minefield/components/result_widget.dart';

class MinedFieldApp extends StatelessWidget {
  const MinedFieldApp({super.key});

  void _restart() {
    print('restart');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: true,
          onRestart: _restart,
        ),
        body: Container(
          child: Text('Board'),
        ),
      ),
    );
  }
}
