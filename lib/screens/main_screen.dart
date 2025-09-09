import 'package:expenzapp/constants/colors.dart';
import 'package:expenzapp/models/expence_model.dart';
import 'package:expenzapp/models/income_model_data.dart';
import 'package:expenzapp/screens/add_new_screen.dart';
import 'package:expenzapp/screens/budgets_screen.dart';
import 'package:expenzapp/screens/home_screen.dart';
import 'package:expenzapp/screens/profile_screen.dart';
import 'package:expenzapp/screens/transaction_screen.dart';
import 'package:expenzapp/services/expence_service.dart';
import 'package:expenzapp/services/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current page index
  int _currentPageIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  //Fetch all expenses
  void fetchAllExpenses() async {
    List<Expense> loadedExpence = await ExpensesService().loadExpences();
    setState(() {
      expenseList = loadedExpence;
      print(expenseList.length);
    });
  }

  //function to fetch all incomes
  void fetchAllIncomes() async {
    List<Income> loadedIncome = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadedIncome;
      print(incomeList.length);
    });
  }

  // Add new expence
  void addNewExpense(Expense newExpense) {
    ExpensesService().saveExpenceses(newExpense, context);
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // Add new income
  void addNewIncome(Income newIncome) {
    IncomeService().saveIncomes(newIncome, context);
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen List
    final List<Widget> pages = [
      HomeScreen(),
      TransactionScreen(),
      AddNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      BudgetsScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kMainColor,
              ),
              child: Icon(Icons.add, size: 35, color: kWhite),
            ),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.rocket), label: "Budget"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
