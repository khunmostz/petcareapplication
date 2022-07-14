class Record {
  String? title;
  int? pay;
  DateTime? date;

  Record({required this.title, required this.pay, required this.date});
}

List<Record> recordData = [
  Record(title: 'ค่าทรายแมว', pay: 4000, date: DateTime.now()),
  Record(title: 'ค่ากัญชาแมว', pay: 200, date: DateTime.now()),
  Record(title: 'ค่าอาหารแมว', pay: 5000, date: DateTime.now()),
  Record(title: 'ค่ายารักษาแมว', pay: 1000, date: DateTime.now()),
];
