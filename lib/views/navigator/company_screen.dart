import 'package:lottie/lottie.dart';
import 'package:my_tech_lib/views/navigator/widget/join_company_widget.dart';
import 'package:my_tech_lib/views/navigator/widget/view_company_widget.dart';

import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/appBar_custom.dart';
import '../../services/models/company_model.dart';
import '../../services/models/user_model.dart';

class CompanyWidget extends StatefulWidget {
  const CompanyWidget(this.user, this.company, {Key? key}) : super(key: key);
  final UserModel user;
  final Company? company;

  @override
  _CompanyWidgetState createState() => _CompanyWidgetState();
}

class _CompanyWidgetState extends State<CompanyWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //TODO TMP
  late bool hasCompany;

  @override
  void initState() {
    super.initState();
    hasCompany = widget.user.companyUuid.isNotEmpty;
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
          child: Icon(
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
                  ? widget.company == null
                      ? Expanded(
                          child: Center(
                            child: Lottie.asset(
                              'assets/lottie/400.json',
                            ),
                          ),
                        )
                      : ViewCompany(widget.company!)
                  : JoinCompany(widget.user),
            ],
          )),
    );
  }
}
