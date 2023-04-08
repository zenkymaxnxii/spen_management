import 'package:flutter/material.dart';

import '../../helper/calendar_help.dart';

// ignore: must_be_immutable
class InputDate extends StatefulWidget {
  InputDate(
      {super.key,
      required this.date,
      required this.subtractDate,
      required this.addDate});
  DateTime date;
  final VoidCallback addDate;
  final VoidCallback subtractDate;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      GestureDetector(
        onTap: () {
          setState(() {
            widget.date = widget.date.subtract(const Duration(days: 1));
            widget.subtractDate();
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
            getDate(widget.date),
            style: const TextStyle(fontSize: 15),
          )),
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            widget.date = widget.date.add(const Duration(days: 1));
            widget.addDate();
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
