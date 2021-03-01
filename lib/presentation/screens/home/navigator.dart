import 'package:answer_sheet_auditor/presentation/providers/bottom_nav_provider.dart';
import 'package:answer_sheet_auditor/presentation/screens/home/home_screen.dart';
import 'package:answer_sheet_auditor/presentation/screens/results/results_screen.dart';
import 'package:answer_sheet_auditor/presentation/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoggedUserBuilder extends StatefulWidget {
  @override
  _LoggedUserBuilderState createState() => _LoggedUserBuilderState();
}

class _LoggedUserBuilderState extends State<LoggedUserBuilder> {
  PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController(
        initialPage: context.read<BottomNavProvider>().currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static List<Widget> children = [
    HomeScreen(),
    ResultsScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Consumer<BottomNavProvider>(
          builder: (_, provider, child) {
            return BottomNavigationBar(
              currentIndex: provider.currentIndex,
              onTap: (index) async {
                _controller.jumpToPage(
                  index,
                );
                context.read<BottomNavProvider>().movePage(index);
              },
              elevation: 0,
              items: const [
                BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    label: 'Results', icon: Icon(Icons.description)),
                BottomNavigationBarItem(
                    label: 'Settings', icon: Icon(Icons.settings)),
              ],
            );
          },
        ),
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          context.read<BottomNavProvider>().movePage(index);
          _controller.jumpToPage(
            index,
          );
        },
        controller: _controller,
        children: children,
      ),
    );
  }
}
