import 'dart:convert';

import 'package:br_vagas_app/controllers/main_controller.dart';
import 'package:br_vagas_app/models/vaga_model.dart';
import 'package:br_vagas_app/pages/widgets/vaga_widget.dart';
import 'package:flutter/material.dart';

import 'package:br_vagas_app/models/label_model.dart';
import 'package:br_vagas_app/models/vaga_model.dart';
import 'package:http/http.dart' as http;

/*
  TODO: Revisar estados, o estado não atualiza ao pegar os dados do controller, mas usando o método localmente, atualiza.
 */
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
  MainController controller = MainController();
}

class _HomePageState extends State<HomePage> {
  List<Vaga> jobsList = [];
  String repositorio = "https://api.github.com/repos/backend-br/vagas/issues";
  void getJobs() async {
    List<Vaga> auxList = [];
    http.Response response =
        await http.get(Uri.parse("$repositorio?per_page=50"));
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
      auxList.add(vaga);
    }
    setState(() {
      jobsList = auxList;
    });
  }

  loadJobs() {
    getJobs();
    // widget.controller.getJobs(repositorio).then((value) => {jobsList = value});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BR VAGAS"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(
                    "Back-End",
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    setState(() {
                      repositorio =
                          "https://api.github.com/repos/backend-br/vagas/issues";
                      jobsList = [];
                      loadJobs();
                    });
                  },
                ),
                ElevatedButton(
                  child: Text(
                    "Front-End",
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    setState(() {
                      repositorio =
                          "https://api.github.com/repos/frontendbr/vagas/issues";
                      jobsList = [];
                      loadJobs();
                    });
                  },
                ),
                ElevatedButton(
                  child: Text(
                    "QA",
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () => setState(() {
                    repositorio =
                        "https://api.github.com/repos/qa-brasil/vagas/issues";
                    jobsList = [];
                    loadJobs();
                  }),
                ),
              ],
            ),
          ),
          Expanded(
              //height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.separated(
                  key: UniqueKey(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return VagaWidget(vaga: this.jobsList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        color: Colors.black,
                      ),
                  itemCount: this.jobsList.length))
        ],
      ),
    );
  }
}
