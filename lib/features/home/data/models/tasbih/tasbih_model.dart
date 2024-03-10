class TasbihModel {
  final int id;
  final String name;
  final int counter;
  final bool static;
  final String type;

  TasbihModel({
    required this.id,
    required this.name,
    required this.counter,
    this.static = false,
    this.type = '',
  });

  factory TasbihModel.fromJson(Map<String, dynamic> json) {
    return TasbihModel(
      id: json['id'],
      name: json['name'],
      counter: json['counter'],
      static: json['id'] > 0 ? false : true,
      type: json['type'] == '' ? json['type'] : '',
    );
  }
}
