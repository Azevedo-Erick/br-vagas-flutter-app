import './label_model.dart';

class Vaga {
  final String url;
  final String title;
  final List<Label> labels;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;
  String description;

  Vaga(
      {required this.url,
      required this.title,
      required this.labels,
      required this.state,
      required this.createdAt,
      required this.updatedAt,
      required this.description});
}
