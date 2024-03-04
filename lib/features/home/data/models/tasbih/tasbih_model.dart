class TasbihModel {
  final int id;
  final String name;
  final int counter;
  final bool static;

  TasbihModel({
    required this.id,
    required this.name,
    required this.counter,
    this.static = false,
  });

  factory TasbihModel.fromJson(Map<String, dynamic> json) {
    return TasbihModel(
      id: json['id'],
      name: json['name'],
      counter: json['counter'],
      static: json['id'] > 0 ? false : true,
    );
  }
}
