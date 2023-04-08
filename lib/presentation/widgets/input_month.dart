import 'package:flutter/material.dart';

import '../../helper/calendar_help.dart';

// ignore: must_be_immutable
class InputMonth extends StatefulWidget {
  InputMonth(
      {super.key,
      required this.date,
      required this.subtractMonth,
      required this.addMonth});
  DateTime date;
  final VoidCallback addMonth;
  final VoidCallback subtractMonth;

  @override
  State<InputMonth> createState() => _InputMonthState();
}

class _InputMonthState extends State<InputMonth> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      GestureDetector(
        onTap: () {
          setState(() {
            widget.date = widget.date
                .subtract(Duration(days: getLastDateOfMonth(widget.date)));
            widget.subtractMonth();
          });
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 35, 36, 38),
            borderRadius: BorderRadius.circular(5),
          ),
          // ignore: prefer__ructors
          child: Center(
              // ignore: prefer__ructors
              child: Text(
            getMonth(widget.date),
            style: const TextStyle(fontSize: 15),
          )),
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            widget.date = widget.date
                .add(Duration(days: getLastDateOfMonth(widget.date)));
            widget.addMonth();
          });
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
          ),
        ),
      ),
    ]);
  }
}
