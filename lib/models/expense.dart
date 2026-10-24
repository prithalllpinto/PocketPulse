import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Formatter to make dates look nice (e.g., "Oct 24, 2026")
final dateFormatter = DateFormat.yMMMd();

// Categories you can choose from
enum ExpenseCategory { food, leisure, travel, work, bills }

// Map categories to icons and colors for UI display
const categoryIcons = {
  ExpenseCategory.food: Icons.fastfood,
  ExpenseCategory.leisure: Icons.movie,
  ExpenseCategory.travel: Icons.flight_takeoff,
  ExpenseCategory.work: Icons.work,
  ExpenseCategory.bills: Icons.receipt_long,
};

class Expense {
  // In lib/models/expense.dart, update the constructor to:
Expense({
  String? id,
  required this.title,
  required this.amount,
  required this.date,
  required this.category,
}) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  // A getter to format the date nicely as a string
  String get formattedDate {
    return dateFormatter.format(date);
  }
}