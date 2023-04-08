// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:spen_management/data/data_local.dart';
import 'package:spen_management/helper/format.dart';
import 'package:spen_management/models/spend.dart';
import 'package:spen_management/presentation/widgets/input_month.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../helper/calendar_help.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? currentDate;
  List<Spend> listSpen = [];
  late Database db;
  CalendarController? calendarController;
  @override
  void initState() {
    calendarController = CalendarController();
    currentDate = DateTime.now();
    getListSpen();
    super.initState();
  }

  Future<void> getListSpen() async {
    db = await openDatabase(join(await getDatabasesPath(), 'spend.db'));
    var list = await SQLManagement(db: db).getListSpend();
    setState(() {
      listSpen = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHead(),
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(top: 10),
        color: const Color.fromARGB(255, 23, 23, 25),
        child: Column(
          children: [
            InputMonth(
                date: currentDate!,
                subtractMonth: subtractMonth,
                addMonth: addMonth),
            const SizedBox(
              height: 10,
            ),
            _buildMonthCalendar(),
            _buildSpenList()
          ],
        ),
      ),
    );
  }

  void subtractMonth() {
    currentDate =
        currentDate!.subtract(Duration(days: getLastDateOfMonth(currentDate!)));
    calendarController!.backward!();
  }

  void addMonth() {
    currentDate =
        currentDate!.add(Duration(days: getLastDateOfMonth(currentDate!)));
    calendarController!.forward!();
  }

  Expanded _buildSpenList() {
    return Expanded(
      flex: 2,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem("Thu nhập", 0),
              _buildItem("Chi tiêu", 0),
              _buildItem("Tổng", 0),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: const Color.fromARGB(255, 35, 36, 38),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("28/03/2023 (Thứ 3)"),
                        Text("-333đ"),
                      ],
                    ),
                  ),
                  _buildIChildList()
                ],
              );
            },
          ),
        )
      ]),
    );
  }

  ListView _buildIChildList() {
    return ListView.builder(
        itemCount: listSpen.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (_, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/meal.png",
                          width: 25,
                          height: 25,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("Ăn uống"),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                            "${listSpen[index].spendAmount.toString().toMoney()}đ"),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )
                      ],
                    )
                  ],
                ),
              ),
              index != 3 - 1
                  ? const Divider(
                      height: 0,
                    )
                  : const SizedBox(),
            ],
          );
        });
  }

  Expanded _buildMonthCalendar() {
    return Expanded(
      flex: 2,
      child: SfCalendar(
        view: CalendarView.month,
        todayHighlightColor: Color.fromARGB(255, 93, 93, 89),
        showCurrentTimeIndicator: true,
        controller: calendarController,
        monthViewSettings: const MonthViewSettings(
            // agendaStyle: AgendaStyle(
            //   backgroundColor: Color(0xff066cccc),
            //   appointmentTextStyle: TextStyle(
            //       fontSize: 14,
            //       fontStyle: FontStyle.italic,
            //       color: Color(0xff0ffcc00)),
            //   dateTextStyle: TextStyle(
            //       fontStyle: FontStyle.italic,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w300,
            //       color: Colors.black),
            //   dayTextStyle: TextStyle(
            //       fontStyle: FontStyle.normal,
            //       fontSize: 20,
            //       fontWeight: FontWeight.w700,
            //       color: Colors.black),
            // ),
            ),
      ),
    );
  }

  Column _buildItem(String title, int money) {
    return Column(
      children: [
        Text(title),
        Text(
          "$moneyđ",
          style: const TextStyle(fontSize: 15, color: Colors.blue),
        ),
      ],
    );
  }

  Stack _buildHead() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
        const Center(
          child: Text(
            "Lịch",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}
