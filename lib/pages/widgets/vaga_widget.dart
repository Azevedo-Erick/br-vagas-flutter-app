import 'package:br_vagas_app/models/label_model.dart';
import 'package:br_vagas_app/models/vaga_model.dart';
import 'package:br_vagas_app/pages/job_description_page.dart';
import 'package:br_vagas_app/pages/widgets/label_widget.dart';
import 'package:flutter/material.dart';

class VagaWidget extends StatefulWidget {
  VagaWidget({Key? key, required this.vaga}) : super(key: key);
  Vaga vaga;

  @override
  State<VagaWidget> createState() => _VagaWidgetState();
}

class _VagaWidgetState extends State<VagaWidget> {
  bool _seeDetails = false;

  List<LabelWidget> buildLabels(List<Label> labels) {
    List<LabelWidget> widgets = [];

    for (int i = 0; i < labels.length; i++) {
      widgets.add(LabelWidget(label: labels[i]));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(widget.vaga.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Nunito",
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Wrap(
                  runSpacing: 5,
                  direction: Axis.horizontal,
                  spacing: 10,
                  children: widget.vaga.labels.length > 0
                      ? [...buildLabels(widget.vaga.labels)]
                      : [Text("A vaga não possui tags")],
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobDescriptionPage(
                          vaga: widget.vaga,
                          key: Key(widget.vaga.title),
                        ),
                      ),
                    ),
                  },
              child: Icon(Icons.search_outlined))
        ],
      ),
    );
  }
}
