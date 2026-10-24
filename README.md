# PocketPulse 💳📱

**PocketPulse** is a responsive, modern personal finance and budget tracker mobile/web application built with Flutter and Dart. It empowers users to log daily expenses, monitor spending habits, and visualize transactional data through interactive charts.

---

## ✨ Features

- **Full CRUD Capabilities:**
  - **Create:** Add new expenses with title, amount, date, and category via an interactive modal sheet.
  - **Read:** View detailed expense lists along with automatically calculated total expenditure.
  - **Update:** Tap any existing transaction to edit and update its details in real-time.
  - **Delete:** Remove entries using smooth swipe-to-delete gestures, backed by an immediate **Undo** snackbar buffer.
- **Visual Data Analytics:** Interactive pie charts built using `fl_chart` to display proportional spending per category.
- **Localization:** Indian Rupee (₹) formatting and localized date handling using the `intl` package.
- **Material Design 3:** Sleek, modern, user-friendly mobile and web UI.

---

## 🛠️ Tech Stack & Architecture

- **Framework:** [Flutter](https://flutter.dev/) (v3.x)
- **Language:** [Dart](https://dart.dev/)
- **State Management:** Reactive State (`StatefulWidget` & `setState`)
- **Key Packages:**
  - `fl_chart`: Dynamic visual analytics and charting.
  - `intl`: Currency and date formatting.
- **Architecture:** Layered Reactive Architecture (Presentation, State Management, Data Layer).

---

## 📁 Project Structure

```text
lib/
├── main.dart                   # Application entry point & main state management
├── models/
│   └── expense.dart            # Expense data model & Category enumeration
└── widgets/
    ├── expenses_list.dart      # Dismissible transaction list view
    ├── new_expense.dart        # Validated modal input form
    └── chart/
        └── chart_widget.dart   # Visual analytics chart component