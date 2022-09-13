import 'package:flutter/material.dart';
import 'package:minefield/models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onSwitchMark;

  const FieldWidget({
    super.key,
    required this.field,
    required this.onOpen,
    required this.onSwitchMark,
  });

  Widget _getImage() {
    if (field.mined && field.isOpen && field.exploded) {
      return Image.asset("assets/images/bomba_0.jpeg");
    }

    if (field.mined && field.isOpen) {
      return Image.asset("assets/images/bomba_1.jpeg");
    }

    if (field.isOpen && field.minedNeighborhoodQuantity > 0) {
      return Image.asset(
          "assets/images/aberto_${field.minedNeighborhoodQuantity}.jpeg");
    }

    if (field.isOpen) {
      return Image.asset("assets/images/aberto_0.jpeg");
    }

    if (field.marked) {
      return Image.asset("assets/images/bandeira.jpeg");
    }

    return Image.asset("assets/images/fechado.jpeg");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onSwitchMark(field),
      child: _getImage(),
    );
  }
}
