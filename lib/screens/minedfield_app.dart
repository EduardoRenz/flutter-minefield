import 'package:flutter/material.dart';
import 'package:minefield/components/field_widget.dart';
import 'package:minefield/components/result_widget.dart';
import 'package:minefield/models/field.dart';

class MinedFieldApp extends StatelessWidget {
  const MinedFieldApp({super.key});

  void _restart() {
    print('restart');
  }

  void _open(Field field) {
    print('open');
  }

  void _switchMark(Field field) {}

  @override
  Widget build(BuildContext context) {
    Field neighbor = Field(line: 1, column: 0);
    neighbor.mine();

    Field field = Field(line: 0, column: 0);
    field.addNeighbor(neighbor);

    try {
      field.switchMarked();
    } catch (e) {}

    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: true,
          onRestart: _restart,
        ),
        body: Container(
          child: FieldWidget(
            field: field,
            onOpen: (field) => _open(field),
            onSwitchMark: (field) => _switchMark(field),
          ),
        ),
      ),
    );
  }
}
