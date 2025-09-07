import 'package:expenzapp/constants/colors.dart';
import 'package:expenzapp/constants/constats.dart';
import 'package:expenzapp/constants/widgets/custom_button.dart';
import 'package:expenzapp/models/expence_model.dart';
import 'package:expenzapp/models/income_model_data.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  //state to chech the expence or income
  int _selectedMethode = 0;

  ExpenseCategory _expenseCategory = ExpenseCategory.health;
  IncomeCategoty _incomeCategoty = IncomeCategoty.salary;
  final TextEditingController _titleControler = TextEditingController();
  final TextEditingController _descriptionControler = TextEditingController();
  final TextEditingController _amountControler = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _amountControler.dispose();
    _descriptionControler.dispose();
    _titleControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethode == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kDefalutPadding,
                  horizontal: kDefalutPadding,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethode = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethode == 0 ? kRed : kWhite,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10,
                            ),
                            child: Text(
                              "Expence",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: _selectedMethode == 0 ? kWhite : kBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethode = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethode == 1 ? kGreen : kWhite,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 47,
                              vertical: 10,
                            ),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: _selectedMethode == 1 ? kWhite : kBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //amount field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How much?",
                        style: TextStyle(
                          color: kWhite.withOpacity(0.8),
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "0",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: kWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //use a data form
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                ),
                // height: MediaQuery.of(context).size.height * .5,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: kDefalutPadding,
                              horizontal: 20,
                            ),
                          ),
                          items:
                              _selectedMethode == 0
                                  ? ExpenseCategory.values.map((Category) {
                                    return DropdownMenuItem(
                                      value: Category,
                                      child: Text(Category.name),
                                    );
                                  }).toList()
                                  : IncomeCategoty.values.map((Category) {
                                    return DropdownMenuItem(
                                      value: Category,
                                      child: Text(Category.name),
                                    );
                                  }).toList(),

                          value:
                              _selectedMethode == 0
                                  ? _expenseCategory
                                  : _incomeCategoty,
                          onChanged: (value) {
                            setState(() {
                              _selectedMethode == 0
                                  ? _expenseCategory = value as ExpenseCategory
                                  : _incomeCategoty = value as IncomeCategoty;
                            });
                          },
                        ),

                        SizedBox(height: kDefalutPadding),

                        //title field
                        TextFormField(
                          controller: _titleControler,
                          decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: kDefalutPadding,
                              horizontal: 20,
                            ),
                          ),
                        ),

                        SizedBox(height: kDefalutPadding),

                        //Description text field
                        TextFormField(
                          controller: _descriptionControler,
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: kDefalutPadding,
                              horizontal: 20,
                            ),
                          ),
                        ),

                        SizedBox(height: kDefalutPadding),

                        //Amount text Field
                        TextFormField(
                          //Only show to user number Key board
                          keyboardType: TextInputType.number,

                          //
                          controller: _amountControler,
                          decoration: InputDecoration(
                            hintText: "Amount",
                            hintStyle: TextStyle(fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: kDefalutPadding,
                              horizontal: 20,
                            ),
                          ),
                        ),

                        SizedBox(height: kDefalutPadding),

                        //date picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  context: context,

                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2026),
                                  // initialDate: DateTime.now(),
                                ).then((Value) {
                                  if (Value != null) {
                                    setState(() {
                                      _selectedDate = Value;
                                    });
                                    // print(_selectedDate);
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: kMainColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: kWhite,
                                      ),

                                      SizedBox(width: 10),
                                      Text(
                                        "Select Date",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(_selectedDate),
                              style: TextStyle(
                                color: kGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: kDefalutPadding),

                        //time picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((Value) {
                                  if (Value != null) {
                                    setState(() {
                                      _selectedTime = DateTime(
                                        _selectedDate.year,
                                        _selectedDate.month,
                                        _selectedDate.day,
                                        Value.hour,
                                        Value.minute,
                                      );
                                    });
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: kYellow,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.timer, color: kWhite),

                                      SizedBox(width: 10),
                                      Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.jm().format(_selectedTime),
                              style: TextStyle(
                                color: kGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: kDefalutPadding),

                        Divider(color: kLightGrey, thickness: 3),

                        SizedBox(height: kDefalutPadding),

                        CustomButton(
                          buttonName: "Add",
                          buttonColor: _selectedMethode == 0 ? kRed : kGreen,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
