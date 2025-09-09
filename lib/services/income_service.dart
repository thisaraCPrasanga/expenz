import 'dart:convert';

import 'package:expenzapp/models/income_model_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //define the key for storing incomes in shared prefrence
  static const String _incomeKey = "incomes";

  //save the income to shared prefrence
  Future<void> saveIncomes(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //convert the existing incomes to a list of Income objects
      List<Income> existingIncomeObjects = [];

      if (existingIncomes != null) {
        existingIncomeObjects =
            existingIncomes
                .map((e) => Income.fromJson(json.decode(e)))
                .toList();
      }

      //add the new income to the list
      existingIncomeObjects.add(income);

      //convert the list of Income objects to a list of json strings
      List<String> updatedIncomes =
          existingIncomeObjects.map((e) => json.encode(e.tojson())).toList();

      //save the updated list to shared prefrence
      await prefs.setStringList(_incomeKey, updatedIncomes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Income added successfully"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print("Error saving income: $e");
    }
  }

  //Load the income from shared prefrence
  Future<List<Income>> loadIncomes() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //convert the existing incomes to a list of Income objects
      List<Income> existingIncomeObjects = [];

      if (existingIncomes != null) {
        existingIncomeObjects =
            existingIncomes
                .map((e) => Income.fromJson(json.decode(e)))
                .toList();
      }

      return existingIncomeObjects;
    } catch (e) {
      print("Error loading income: $e");
      return [];
    }
  }
}
