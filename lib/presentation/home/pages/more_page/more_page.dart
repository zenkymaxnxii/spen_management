// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  List<Item> list = [];
  List<Item> list2 = [];

  @override
  void initState() {
    super.initState();
    list = [
      Item(
          icon: Icons.settings_outlined,
          title: "Cài đặt cơ bản",
          route: "route"),
    ];
    list2 = [
      Item(
          icon: Icons.settings_outlined,
          title: "Cài đặt cơ bản",
          route: "route"),
      Item(
          icon: Icons.settings_outlined,
          title: "Cài đặt cơ bản",
          route: "route"),
      Item(
          icon: Icons.settings_outlined,
          title: "Cài đặt cơ bản",
          route: "route"),
      Item(
          icon: Icons.settings_outlined,
          title: "Cài đặt cơ bản",
          route: "route"),
      Item(
          icon: Icons.settings_outlined,
          title: "Cài đặt cơ bản",
          route: "route"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildHead(), _builBody()],
    );
  }

  Expanded _builBody() {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      width: double.infinity,
      color: const Color.fromARGB(255, 16, 15, 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildItemList(list),
            const SizedBox(
              height: 20,
            ),
            _buildItemList(list2),
            const SizedBox(
              height: 20,
            ),
            _buildItemList(list2),
            const SizedBox(
              height: 20,
            ),
            _buildItemList(list
              ..add(
                Item(
                    icon: Icons.settings_outlined,
                    title: "Cài đặt cơ bản",
                    route: "route"),
              )
              ..add(
                Item(
                    icon: Icons.settings_outlined,
                    title: "Cài đặt cơ bản",
                    route: "route"),
              )),
            const SizedBox(
              height: 20,
            ),
            _buildItemList(list
              ..add(
                Item(
                    icon: Icons.settings_outlined,
                    title: "Cài đặt cơ bản",
                    route: "route"),
              )
              ..add(
                Item(
                    icon: Icons.settings_outlined,
                    title: "Cài đặt cơ bản",
                    route: "route"),
              )),
          ],
        ),
      ),
    ));
  }

  ListView _buildItemList(List<Item> listItem) {
    return ListView.builder(
      itemCount: listItem.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 23, 23, 25),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(index == 0 ? 5 : 0),
              topRight: Radius.circular(index == 0 ? 5 : 0),
              bottomLeft: Radius.circular(index == listItem.length - 1 ? 5 : 0),
              bottomRight:
                  Radius.circular(index == listItem.length - 1 ? 5 : 0),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(listItem[index].icon),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(listItem[index].title),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )
                  ],
                ),
              ),
              index != listItem.length - 1
                  ? const Divider(
                      height: 0,
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
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
              Icons.help_outline_outlined,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        const Center(
          child: Text(
            "Khác",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}

class Item {
  IconData icon;
  String title;
  String route;
  Item({
    required this.icon,
    required this.title,
    required this.route,
  });
}
