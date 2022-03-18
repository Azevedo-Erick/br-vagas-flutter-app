import 'package:br_vagas_app/controllers/main_controller.dart';
import 'package:br_vagas_app/models/vaga_model.dart';
import 'package:br_vagas_app/pages/widgets/vaga_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
  MainController controller = MainController();
}

class _HomePageState extends State<HomePage> {
  List<Vaga> jobsList = [];

  loadJobs() {
    widget.controller.getJobs().then((value) => {jobsList = value});
    setState(() {});
    print(jobsList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BR VAGAS"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                child: Text(
                  "Back-End",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  this.loadJobs();
                },
              ),
              Text(
                "Front-End",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "Mobile",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "QA",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.separated(
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
