// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:spen_management/data/data_local.dart';
import 'package:spen_management/helper/format.dart';
import 'package:spen_management/models/spend.dart';
import 'package:spen_management/models/spend_date.dart';
import 'package:spen_management/models/spend_type.dart';
import 'package:spen_management/presentation/widgets/input_date.dart';
import 'package:sqflite/sqflite.dart';

class AddSpenPage extends StatefulWidget {
  const AddSpenPage({super.key});

  @override
  State<AddSpenPage> createState() => _AddSpenPageState();
}

class _AddSpenPageState extends State<AddSpenPage> {
  bool _toogleButton = true;
  List<SpendType> _listSpen = [];
  List<SpendType> _listSpen2 = [];
  var _selectedIndex = -1;
  DateTime? currentDate;
  TextEditingController? priceEditingController;
  TextEditingController? noteEditingController;
  late final Database db;

  @override
  void initState() {
    getList();
    super.initState();
    currentDate = DateTime.now();
    priceEditingController = TextEditingController();
    noteEditingController = TextEditingController();
    _listSpen = [];
    _listSpen2 = [];
  }

  Future<void> getList() async {
    db = await openDatabase(join(await getDatabasesPath(), 'spend.db'));
    var list = await db.query('SpendTypeTable');
    setState(() {
      _listSpen = list
          .where((element) => element['type'] == 0)
          .map((e) => SpendType.fromMap(e))
          .toList();
      _listSpen2 = list
          .where((element) => element['type'] == 1)
          .map((e) => SpendType.fromMap(e))
          .toList();
    });
  }

  Future<void> addNewSpend() async {
    var idDate =
        await SQLManagement(db: db).insert(SpendDate(spendDate: currentDate!));

    SpendType spendType =
        _toogleButton ? _listSpen[_selectedIndex] : _listSpen2[_selectedIndex];
    Spend spend = Spend(
        idSpenType: spendType.id!,
        idSpenDate: idDate,
        spendNote: noteEditingController!.text.toString(),
        spendAmount: int.parse(
            priceEditingController!.text.replaceAll(".", "").toString()));

    SQLManagement(db: db).insert(spend);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeadToogle(),
        _buildBody(),
        _buildFooterButton(),
      ],
    );
  }

  Stack _buildHeadToogle() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Positioned(
        //   right: 0,
        //   child: Padding(
        //     padding: const EdgeInsets.all(15),
        //     child: Icon(
        //       Icons.edit_outlined,
        //       color: Colors.white.withOpacity(0.8),
        //     ),
        //   ),
        // ),
        Center(
          child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 35, 36, 38)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                _toggleButton(_toogleButton, "Tiền chi"),
                _toggleButton(!_toogleButton, "Tiền thu"),
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
            if (_selectedIndex >= 0) {
              _toogleButton
                  ? _listSpen[_selectedIndex].selected = false
                  : _listSpen2[_selectedIndex].selected = false;
            }
            _selectedIndex = -1;
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

  Widget _buildBody() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        color: const Color.fromARGB(255, 23, 23, 25),
        child: Column(
          children: [
            _buildBodyItem("Ngày", TypeBodyItem.day),
            const Divider(height: 0),
            _buildBodyItem("Ghi chú", TypeBodyItem.inputText),
            const Divider(
              height: 0,
            ),
            _buildBodyItem(_toogleButton ? "Tiền chi" : "Tiền thu",
                TypeBodyItem.inputMoney),
            const Divider(
              height: 0,
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              // ignore: prefer__literals_to_create_immutables
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer__literals_to_create_immutables
                  children: [
                    // ignore: prefer__ructors
                    const Text(
                      "Danh mục",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _toogleButton
                            ? _listSpen.length
                            : _listSpen2.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                crossAxisCount: 3,
                                childAspectRatio: 4.5 / 3.5),
                        itemBuilder: ((context, index) {
                          return _buildGridChildCard(index);
                        }),
                      ),
                    ),
                  ]),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildItemContent(TypeBodyItem typeBodyItem) {
    Widget contentWidget = const SizedBox();
    switch (typeBodyItem) {
      case TypeBodyItem.day:
        contentWidget = InputDate(
          date: currentDate!,
          addDate: () {
            currentDate = currentDate!.add(const Duration(days: 1));
          },
          subtractDate: () {
            currentDate = currentDate!.subtract(const Duration(days: 1));
          },
        );
        break;
      case TypeBodyItem.inputText:
        contentWidget = TextField(
          controller: noteEditingController,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 3,
          decoration: const InputDecoration(
              isDense: true,
              hintText: "Chưa nhập ghi chú",
              contentPadding: EdgeInsets.all(8),
              border: InputBorder.none),
        );
        break;
      case TypeBodyItem.inputMoney:
        contentWidget = Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 35, 36, 38),
                  borderRadius: BorderRadius.circular(5),
                ),
                // ignore: prefer__ructors
                child: TextField(
                  controller: priceEditingController,
                  onChanged: (value) {
                    if (value.isEmpty) return;
                    value = value.replaceAll(".", "");
                    if (value[0] == "0") {
                      priceEditingController!.text = "";
                      return;
                    }
                    priceEditingController!.text = value.toMoney();
                    priceEditingController!.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: priceEditingController!.text.length));
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                      hintText: "0",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                      border: InputBorder.none),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text('đ'),
              ),
            )
          ],
        );
        break;
    }
    return Expanded(child: contentWidget);
  }

  Widget _buildBodyItem(String title, TypeBodyItem typeBodyItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            width: 10,
          ),
          _buildItemContent(typeBodyItem),
        ],
      ),
    );
  }

  GestureDetector _buildGridChildCard(int index) {
    SpendType spenType = _toogleButton ? _listSpen[index] : _listSpen2[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedIndex >= 0) {
            _toogleButton
                ? _listSpen[_selectedIndex].selected = false
                : _listSpen2[_selectedIndex].selected = false;
          }
          spenType.selected = true;
          _selectedIndex = index;
        });
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: const Color.fromARGB(255, 23, 23, 25),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
                color: spenType.selected
                    ? const Color.fromARGB(255, 86, 86, 88)
                    : const Color.fromARGB(255, 40, 40, 42),
                width: spenType.selected ? 2 : 1)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              spenType.icon.isEmpty
                  ? const SizedBox()
                  : Image.asset(
                      "assets/icons/${spenType.icon}",
                      width: 40,
                      height: 40,
                      color: Colors.blue,
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(spenType.spendName),
                  spenType.icon.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ]),
      ),
    );
  }

  Widget _buildFooterButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 90, 90, 91),
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            if (_selectedIndex < 0) {
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //   content: Text("Please select spend type!"),
              //   backgroundColor: Colors.greenAccent,
              //   behavior: SnackBarBehavior.floating,
              // ));
            } else {
              if (kDebugMode) {
                print("Lưu");
                if (_toogleButton) {
                  print("Type spen:${_listSpen[_selectedIndex]}");
                } else {
                  print("Type spen:${_listSpen2[_selectedIndex]}");
                }
                print("Day: ${currentDate.toString()}");
                print("Price: ${priceEditingController!.text}");
                print("Note: ${noteEditingController!.text}");
                addNewSpend();
              }
            }
          },
          child: Text("Lưu khoản ${_toogleButton ? 'chi' : 'thu'}")),
    );
  }
}

enum TypeBodyItem {
  day,
  inputText,
  inputMoney,
}
