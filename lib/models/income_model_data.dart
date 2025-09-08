import 'package:flutter/widgets.dart';

//income category enum
enum IncomeCategoty { freelance, salary, passive, sales }

//income icon
final Map<IncomeCategoty, String> incomeCategoryImages = {
  IncomeCategoty.freelance: "assets/images/freelance.png",
  IncomeCategoty.passive: "assets/images/car.png",
  IncomeCategoty.salary: "assets/images/health.png",
  IncomeCategoty.sales: "assets/images/salary.png",
};

//incom colors
final Map<IncomeCategoty, Color> incomeCategotyColor = {
  IncomeCategoty.freelance: Color(0xffe57373),
  IncomeCategoty.passive: Color(0xff81c784),
  IncomeCategoty.salary: Color(0xff64b5f6),
  IncomeCategoty.sales: Color(0xffffd54f),
};

//income model
class Income {
  final int id;
  final String title;
  final double amount;
  final IncomeCategoty categoty;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoty,
    required this.date,
    required this.time,
    required this.description,
  });

  //convert income object to json object for shared preferences
  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'categoty': categoty.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  //create income object from json object
  factory Income.fromJson(Map<String, dynamic> data) {
    return Income(
      id: data['id'],
      title: data['title'],
      amount: data['amount'],
      categoty: IncomeCategoty.values[data['categoty']],
      date: DateTime.parse(data['date']),
      time: DateTime.parse(data['time']),
      description: data['description'],
    );
  }
}
