import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key, required this.expenses});

  final List<Expense> expenses;

  // Calculate total expense amount for each category
  Map<ExpenseCategory, double> get categoryTotals {
    final Map<ExpenseCategory, double> totals = {
      for (var category in ExpenseCategory.values) category: 0.0,
    };

    for (final expense in expenses) {
      totals[expense.category] = (totals[expense.category] ?? 0) + expense.amount;
    }

    return totals;
  }

  double get grandTotal {
    return expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    final totals = categoryTotals;
    final totalSum = grandTotal;

    // Color palette for categories
    final Map<ExpenseCategory, Color> categoryColors = {
      ExpenseCategory.food: Colors.orangeAccent,
      ExpenseCategory.leisure: Colors.purpleAccent,
      ExpenseCategory.travel: Colors.blueAccent,
      ExpenseCategory.work: Colors.greenAccent,
      ExpenseCategory.bills: Colors.redAccent,
    };

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total Spent: \₹${totalSum.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: totalSum == 0
                  ? const Center(child: Text('No expenses recorded yet.'))
                  : PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 35,
                        sections: ExpenseCategory.values.map((category) {
                          final amount = totals[category] ?? 0;
                          final percentage = totalSum == 0 ? 0.0 : (amount / totalSum) * 100;

                          return PieChartSectionData(
                            color: categoryColors[category],
                            value: amount == 0 ? 0.0001 : amount,
                            title: percentage > 5 ? '${percentage.toStringAsFixed(0)}%' : '',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}