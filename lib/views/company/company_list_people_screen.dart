import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tech_lib/services/models/user_model.dart';

import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/color_const.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/local/pref.dart';
import '../../services/models/company_model.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/repositories/company_repository.dart';

class CompanyListPeopleWidget extends StatefulWidget {
  CompanyListPeopleWidget(this.company, {Key? key}) : super(key: key);
  Company company;

  @override
  _CompanyListPeopleWidgetState createState() => _CompanyListPeopleWidgetState();
}

class _CompanyListPeopleWidgetState extends State<CompanyListPeopleWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController = TextEditingController();
  List<UserModel> listCompanyUser = [];
  String uuidUser = '';
  bool _loader = false;

  @override
  void initState() {
    super.initState();
    getUserCompany();
  }

  Future<void> getUserCompany() async {
    setState(() {
      _loader = true;
    });
    ResponseApi? response = await CompanyRepository().getUserCompany(context, widget.company.uuid);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => UserModel.fromJson(doc)).toList();
      listCompanyUser.addAll(result.cast<UserModel>());
    }

    uuidUser = await LocalPref().getString("uuid_user");
    setState(() {
      _loader = false;
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).background,
        automaticallyImplyLeading: true,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24.0,
          ),
        ),
        title: Text(
          widget.company.name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 5.0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h, top: 15.h),
            child: Container(
              width: double.infinity,
              height: 50.0,
              decoration: BoxDecoration(
                color: AppTheme.of(context).secondaryBackground,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x3F14181B),
                    offset: Offset(0.0, 3.0),
                  )
                ],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CustomTextField(
                fillColor: AppTheme.of(context).secondaryBackground,
                controller: textController,
                hintText: "Recherche par nom ...",
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: ColorConst.primary,
                  size: 24.0,
                ),
                validator: Validators.validateEmpty,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Text(
                "Liste des informations",
                style: TextStyle(
                  color: AppTheme.of(context).primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: listCompanyUser.length,
                itemBuilder: (context, listViewIndex) {
                  final element = listCompanyUser[listViewIndex];
                  return _loader
                      ? Center(
                          child: Lottie.asset(
                            'assets/lottie/list_loader.json',
                          ),
                        )
                      : listCompanyUser.isEmpty
                          ? Center(
                              child: Lottie.asset(
                                'assets/lottie/list_empty.json',
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).secondaryBackground,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x3F14181B),
                                      offset: Offset(0.0, 3.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10.w),
                                        child: Container(
                                          width: 40,
                                          padding: const EdgeInsets.all(2.0),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: element.profile_url.isEmpty
                                              ? Image.asset(
                                                  'assets/images/tlchargement.png',
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  element.profile_url,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Text(element.name + " " + element.lastname,
                                          style: TextStyle(
                                            color: AppTheme.of(context).primary,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const Spacer(),
                                      if (uuidUser == element.uuid)
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.w),
                                          child: Container(
                                            width: 50,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context).primary,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Moi",
                                                style: TextStyle(
                                                  color: AppTheme.of(context).secondaryBackground,
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
