import 'package:br_vagas_app/models/label_model.dart';
import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({Key? key, required this.label}) : super(key: key);

  final Label label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset.fromDirection(3),
                blurRadius: 2)
          ],
          color: new Color(int.parse("0xff${this.label.color}"))),
      child: Text(
        label.name,
        style: TextStyle(
          color: Colors.white,
          shadows: [
            Shadow(
                color: Colors.black,
                offset: Offset.fromDirection(3),
                blurRadius: 2)
          ],
        ),
      ),
    );
  }
}
