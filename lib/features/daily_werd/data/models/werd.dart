class WerdModel{
  final String title;
  final bool done;
  WerdModel({required this.title,required this.done});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
    };
  }

  factory WerdModel.fromJson(Map<String, dynamic> json) {
    return WerdModel(
      title: json['title'],
      done: json['done'],
    );
  }

  WerdModel copyWith({
    String? title,
    bool? done,
  }) {
    return WerdModel(
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }
}