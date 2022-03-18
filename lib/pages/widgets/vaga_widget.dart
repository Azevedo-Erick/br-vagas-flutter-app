import 'package:br_vagas_app/models/vaga_model.dart';
import 'package:flutter/material.dart';

class VagaWidget extends StatefulWidget {
  VagaWidget({Key? key, required this.vaga}) : super(key: key);
  Vaga vaga;

  @override
  State<VagaWidget> createState() => _VagaWidgetState();
}

class _VagaWidgetState extends State<VagaWidget> {
  bool _seeDetails = false;

  Widget renderWithoutDetails() {
    return Expanded(
      child: Row(
        children: [
          Column(
            children: [Text(widget.vaga.title)],
          ),
          ElevatedButton(
              onPressed: () => {!this._seeDetails}, child: Icon(Icons.details))
        ],
      ),
    );
  }

  Widget renderWithDetails() {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [Text(widget.vaga.title)],
              ),
              ElevatedButton(
                  onPressed: () => {!this._seeDetails},
                  child: Icon(Icons.details))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(widget.vaga.description),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return renderWithoutDetails();
  }
}
