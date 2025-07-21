class Routine {
  final String id;
  final String title;
  bool isCompleted;

  Routine({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isCompleted': isCompleted,
  };

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
    id: json['id'],
    title: json['title'],
    isCompleted: json['isCompleted'],
  );
}
