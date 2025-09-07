import 'package:expenzapp/constants/colors.dart';
import 'package:expenzapp/constants/constats.dart';

import 'package:flutter/material.dart';

class IncomeExpenceCard extends StatefulWidget {
  final String buttonIcon;
  final String buttonName;
  final double buttonValue;
  final Color buttonColor;
  const IncomeExpenceCard({
    super.key,
    required this.buttonIcon,
    required this.buttonName,
    required this.buttonValue,
    required this.buttonColor,
  });

  @override
  State<IncomeExpenceCard> createState() => _IncomeExpenceCardState();
}

class _IncomeExpenceCardState extends State<IncomeExpenceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        color: widget.buttonColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(kDefalutPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kWhite,
                ),
                child: Center(
                  child: Image.asset(
                    widget.buttonIcon,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.buttonName,
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    ("\$${widget.buttonValue.toString()}"),
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
