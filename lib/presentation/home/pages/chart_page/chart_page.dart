// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  var _toogleButton = false;
  var _toogle = true;
  final List<_PieData> _list = [];

  @override
  void initState() {
    super.initState();
    _list.add(_PieData("10", 10, Colors.red)..text = "quan");
    _list.add(_PieData("80", 80, Colors.green)..text = "80%");
    _list.add(_PieData("10", 10, null));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeadToogle(),
        _buildChart(),
      ],
    );
  }

  Expanded _buildChart() {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      width: double.infinity,
      color: const Color.fromARGB(255, 23, 23, 25),
      child: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
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
                child: const Center(
                  child: Text.rich(
                    TextSpan(
                      text: '03/2022 ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '(01/03 - 31/03)',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            _buildChildContainer("Chi tiêu", 0),
            const SizedBox(
              width: 10,
            ),
            _buildChildContainer("Thu nhập", 0),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(children: [_buildChildContainer("Thu chi", 0)]),
        const SizedBox(
          height: 5,
        ),
        Expanded(
            child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _toogleThuChi("Chi tiêu", _toogle),
                _toogleThuChi("Thu nhập", !_toogle),
              ],
            ),
            Center(
              child: SfCircularChart(
                // title: ChartTitle(text: 'Sales by sales person'),
                legend: Legend(
                  isVisible: true,
                ),
                series: <PieSeries<_PieData, String>>[
                  PieSeries<_PieData, String>(
                      explode: true,
                      explodeIndex: 0,
                      dataSource: _list,
                      xValueMapper: (_PieData data, _) => data.xData,
                      yValueMapper: (_PieData data, _) => data.yData,
                      dataLabelMapper: (_PieData data, _) => data.text,
                      pointColorMapper: (_PieData data, _) => data.color,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
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
                              children: const [
                                Text("-333đ"),
                                Icon(
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
                },
              ),
            )
          ],
        ))
      ]),
    ));
  }

  Expanded _toogleThuChi(String title, bool enable) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (!enable) _toogle = !_toogle;
          });
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: enable ? Colors.blue : Colors.white, width: 2),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                  color: enable ? Colors.blue : Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }

  Expanded _buildChildContainer(String title, int total) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 40, 41, 44),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text("$totalđ"),
          ],
        ),
      ),
    );
  }

  Stack _buildHeadToogle() {
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
        Center(
          child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 35, 36, 38)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                _toggleButton(_toogleButton, "Hàng ngày"),
                _toggleButton(!_toogleButton, "Hàng năm"),
              ])),
        )
      ],
    );
  }

  Widget _toggleButton(bool enable, String title) {
    return GestureDetector(
      onTap: () {
        if (!enable) {
          setState(() {
            _toogleButton = !_toogleButton;
          });
        }
      },
      child: Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          color: enable
              ? const Color.fromARGB(255, 90, 90, 91)
              : const Color.fromARGB(255, 35, 36, 38),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.color);
  final String xData;
  final num yData;
  String? text;
  Color? color;
}
