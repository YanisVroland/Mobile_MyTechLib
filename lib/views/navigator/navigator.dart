import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';
import 'company_widget.dart';
import 'home_widget.dart';
import 'information_widget.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'home';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'information': const InformationWidget(),
      'home': const HomeWidget(),
      'company': const CompanyWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: AppTheme.of(context).background,
        selectedItemColor: AppTheme.of(context).primary,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Information',
            icon: Icon(
              Icons.credit_card,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.stacked_line_chart_rounded,
              size: 24.0,
            ),
            tooltip: '',
          ),
          BottomNavigationBarItem(
            label: 'Bibliothèque',
            icon: Icon(
              Icons.stacked_line_chart_rounded,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.stacked_line_chart_rounded,
              size: 24.0,
            ),
            tooltip: '',
          ),
          BottomNavigationBarItem(
            label: 'Entreprise',
            icon: Icon(
              Icons.account_circle_outlined,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.account_circle_rounded,
              size: 24.0,
            ),
            tooltip: '',
          )
        ],
      ),
    );
  }
}
