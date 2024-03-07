import 'package:my_tech_lib/views/navigator/widget/join_company_widget.dart';
import 'package:my_tech_lib/views/navigator/widget/view_company_widget.dart';

import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/appBar_custom.dart';

class CompanyWidget extends StatefulWidget {
  const CompanyWidget({Key? key}) : super(key: key);

  @override
  _CompanyWidgetState createState() => _CompanyWidgetState();
}

class _CompanyWidgetState extends State<CompanyWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //TODO TMP
  bool hasCompany = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      floatingActionButton: Visibility(
        visible: hasCompany,
        child: FloatingActionButton(
          onPressed: () async {
            //TODO Nav 'createCompanyLibrary',
          },
          backgroundColor: AppTheme.of(context).primary,
          elevation: 8.0,
          child:  Icon(
            Icons.post_add_rounded,
            color: AppTheme.of(context).background,
            size: 32.0,
          ),
        ),
      ),
      appBar: const CustomAppBar(),
      body: SafeArea(
          top: true,
          child: Stack(
            children: [
              hasCompany
                  ? const ViewCompany()
                  : const JoinCompany(),
            ],
          )),
    );
  }
}
