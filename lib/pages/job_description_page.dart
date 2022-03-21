import 'package:br_vagas_app/models/label_model.dart';
import 'package:br_vagas_app/models/vaga_model.dart';
import 'package:br_vagas_app/pages/widgets/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class JobDescriptionPage extends StatelessWidget {
  const JobDescriptionPage({Key? key, required this.vaga}) : super(key: key);

  final Vaga vaga;

  List<LabelWidget> buildLabels(List<Label> labels) {
    List<LabelWidget> widgets = [];

    for (int i = 0; i < labels.length; i++) {
      widgets.add(LabelWidget(label: labels[i]));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vaga.title),
      ),
      body: Column(
        children: [
          Text(
              "Estado da vaga: ${vaga.state == 'open' ? 'Aberta' : 'Fechado'}"),
          Text(
              "Vaga criada em: ${vaga.createdAt.day}-${vaga.createdAt.month}-${vaga.createdAt.year}"),
          Text(
              "Última atualização: ${vaga.updatedAt.day}-${vaga.updatedAt.month}-${vaga.updatedAt.year}"),
          Wrap(
            runSpacing: 5,
            direction: Axis.horizontal,
            spacing: 10,
            children: vaga.labels.length > 0
                ? [...buildLabels(vaga.labels)]
                : [Text("A vaga não possui tags")],
          ),
          Expanded(
              child: Markdown(
            data: vaga.description,
          ))
        ],
      ),
    );
  }
}
