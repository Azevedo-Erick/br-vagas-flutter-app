import 'dart:convert';

import 'package:br_vagas_app/models/label_model.dart';
import 'package:br_vagas_app/models/vaga_model.dart';
import 'package:http/http.dart' as http;

class MainController {
  Future<List<Vaga>> getJobs() async {
    List<Vaga> jobsList = [];
    http.Response response = await http.get(Uri.parse(
        "https://api.github.com/repos/backend-br/vagas/issues?per_page=100"));
    var results = jsonDecode(response.body);
    for (int i = 0; i < results.length; i++) {
      List<Label> labels = [];
      for (int j = 0; j < results[i]["labels"].length; j++) {
        labels.add(Label(
            name: results[i]["labels"][j]["name"],
            color: results[i]["labels"][j]["color"]));
      }
      Vaga vaga = Vaga(
          url: results[i]["url"],
          createdAt: DateTime.parse(results[i]["created_at"]),
          description: results[i]["body"],
          labels: labels,
          state: results[i]["state"],
          title: results[i]["title"],
          updatedAt: DateTime.parse(results[i]["updated_at"]));
      jobsList.add(vaga);
    }
    return jobsList;
  }
}
