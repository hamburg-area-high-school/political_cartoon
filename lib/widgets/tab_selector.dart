import 'package:flutter/material.dart';
import 'package:history_app/blocs/tab/tab.dart';

class TabSelector extends StatelessWidget {
  TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: AppTab.values.indexOf(activeTab),
        onTap: (index) => onTabSelected(AppTab.values[index]),
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined,
                  key: Key('TabSelector_DailyTab')),
              label: 'Daily'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.list, key: Key('TabSelector_AllTab')),
              label: 'All'),
        ]);
  }
}
