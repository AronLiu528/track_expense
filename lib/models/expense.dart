import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid(); //lesson .98

final formatter = DateFormat.yMd(); //lesson .104

enum Category { food, travel, leisure, work } //Dart視為'字串'，lesson .99

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
}; //lesson .104

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //生成唯一的ID，並在初使化Expense類時將其作為初始值賦予給ID屬性

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; //lesson .99

  String get formattedDate {
    return formatter.format(date);
  } //回傳一個字串型態，格式化後的日期格式，lesson .104
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); //在class中額外添加構造函數，lesson .130

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum +=expense.amount; //等同 sum = sum + expense.amount; 
    }
    return sum;
  }
}//lesson .129
