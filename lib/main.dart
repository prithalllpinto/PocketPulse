import 'package:flutter/material.dart';
import 'models/expense.dart';
import 'widgets/expenses_list.dart';
import 'widgets/new_expense.dart';
import 'widgets/expense_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PocketPulse',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
        ),
      ),
      home: const ExpensesScreen(),
    );
  }
}

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: ExpenseCategory.work,
    ),
    Expense(
      title: 'Groceries',
      amount: 45.50,
      date: DateTime.now(),
      category: ExpenseCategory.food,
    ),
  ];

  void _openAddExpenseOverlay({Expense? expenseToEdit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(
        existingExpense: expenseToEdit,
        onSaveExpense: (expense) {
          if (expenseToEdit == null) {
            _addExpense(expense);
          } else {
            _updateExpense(expense);
          }
        },
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _updateExpense(Expense updatedExpense) {
    setState(() {
      final index = _registeredExpenses.indexWhere((e) => e.id == updatedExpense.id);
      if (index >= 0) {
        _registeredExpenses[index] = updatedExpense;
      }
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
        onSelectExpense: (expense) {
          _openAddExpenseOverlay(expenseToEdit: expense);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PocketPulse Tracker'),
        actions: [
          IconButton(
            onPressed: () => _openAddExpenseOverlay(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          ExpenseChart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}