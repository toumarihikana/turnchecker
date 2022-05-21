// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'card_check_model.dart';

class CheckListPage extends StatefulWidget {
  const CheckListPage({Key? key}) : super(key: key);

  final String title = 'Checklist for card activation';

  @override
  _CheckListPageState createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  List<CardCheckModel> myCheckBoxModelList = CardCheckModel.getUsers();

  List<CardCheckModel> opponentCheckBoxModelList = CardCheckModel.getUsers();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    final _tab = <Tab>[
      const Tab(text: 'myself', icon: Icon(Icons.person)),
      const Tab(text: 'opponent', icon: Icon(Icons.person_outline))
    ];

    return MaterialApp(
      home: DefaultTabController(
        length: _tab.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Checklist for card activation'),
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              tabs: _tab,
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) => CheckboxListTile(
                        value: myCheckBoxModelList[index].isCheck,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? val) {
                          itemChange(myCheckBoxModelList, val!, index);
                        },
                        key: Key('$index'),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(myCheckBoxModelList[index].cardName),
                      ),
                      itemCount: myCheckBoxModelList.length,
                      onReorder: (int oldIndex, int newIndex) {
                        _onReorder(myCheckBoxModelList, oldIndex, newIndex);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resetCheckBox(myCheckBoxModelList);
                      },
                      child: const Text(
                        'Reset',
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) => CheckboxListTile(
                        value: opponentCheckBoxModelList[index].isCheck,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? val) {
                          itemChange(opponentCheckBoxModelList, val!, index);
                        },
                        key: Key('$index'),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        title: Text(opponentCheckBoxModelList[index].cardName),
                      ),
                      itemCount: opponentCheckBoxModelList.length,
                      onReorder: (int oldIndex, int newIndex) {
                        _onReorder(
                            opponentCheckBoxModelList, oldIndex, newIndex);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resetCheckBox(opponentCheckBoxModelList);
                      },
                      child: const Text(
                        'Reset',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            backgroundColor: Colors.green,
            mini: true,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).primaryColor,
            notchMargin: 6.0,
            shape: const AutomaticNotchedShape(
              RoundedRectangleBorder(),
              StadiumBorder(
                side: BorderSide(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 30, 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.folder_open_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 170,
                    ),
                    child: const Text.rich(
                      TextSpan(
                        text: '12345678901234567890',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.save_as,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onReorder(List<CardCheckModel> items, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    items.insert(newIndex, items.removeAt(oldIndex));
  }

  void itemChange(List<CardCheckModel> items, bool val, int index) {
    setState(() {
      items[index].isCheck = val;
    });
  }

  void resetCheckBox(List<CardCheckModel> items) {
    setState(() {
      items.forEach((element) {
        element.isCheck = false;
      });
    });
  }
}
