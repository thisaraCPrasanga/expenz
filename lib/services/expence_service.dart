import 'dart:convert';

import 'package:expenzapp/models/expence_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesService {
  List<Expense> expenceList = [];

  //Define th ekey for storing expences in shared prefrence
  static String _expenceKey = "expences";

  //save the expence to shared prefrence
  Future<void> saveExpenceses(Expense expence, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      //get the existing expences from shared prefrence
      List<String>? existingExpences = pref.getStringList(_expenceKey);

      //convert the existing expences to a list of Expence objects
      List<Expense> existingExpenseObjects = [];

      if (existingExpences != null) {
        existingExpences.map((e) => Expense.fromJson(json.decode(e))).toList();
      }
      //add the new expence to the list
      existingExpenseObjects.add(expence);

      //convert the list of expence objects BACK to a list of strings
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJson())).toList();

      //save the updated list back to shared prefrence
      await pref.setStringList(_expenceKey, updatedExpenses);

      //show a snackbar to indicate success(message)
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expence added successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      //show a snackbar to indicate error (message)
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on Adding Expence"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //load the expences from shared prefrence
  Future<List<Expense>> loadExpences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpences = pref.getStringList(_expenceKey);

    //convert the existing expences to a list of Expence objects
    List<Expense> loadedExpenses = [];

    if (existingExpences != null) {
      loadedExpenses =
          existingExpences
              .map((e) => Expense.fromJson(json.decode(e)))
              .toList();
    }
    return loadedExpenses;
  }
}
