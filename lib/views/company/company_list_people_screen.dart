import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tech_lib/services/models/globalData_model.dart';
import 'package:my_tech_lib/services/models/user_model.dart';
import 'package:my_tech_lib/services/repositories/user_repository.dart';

import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/color_const.dart';
import '../../app/theme/snackBar_const.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/local/pref.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/repositories/company_repository.dart';

class CompanyListPeopleWidget extends StatefulWidget {
  CompanyListPeopleWidget(this.globalData, {Key? key}) : super(key: key);
  GlobalData globalData;

  @override
  _CompanyListPeopleWidgetState createState() => _CompanyListPeopleWidgetState();
}

class _CompanyListPeopleWidgetState extends State<CompanyListPeopleWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController = TextEditingController();
  List<UserModel> listCompanyUser = [];
  List<UserModel> searchListCompanyUser = [];
  List<String> selectionUsers = [];
  String uuidUser = '';
  bool _loader = false;
  bool _loaderButton = false;

  @override
  void initState() {
    super.initState();
    getUserCompany();
  }

  Future<void> getUserCompany() async {
    setState(() {
      _loader = true;
    });
    ResponseApi? response = await CompanyRepository().getUserCompany(context, widget.globalData.company!.uuid);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => UserModel.fromJson(doc)).toList();
      listCompanyUser = result.cast<UserModel>();
      searchListCompanyUser = listCompanyUser;
    }

    uuidUser = await LocalPref().getString("uuid_user");
    setState(() {
      _loader = false;
    });
  }

  addAdmin() async {
    setState(() {
      _loaderButton = true;
    });

    ResponseApi? response = await UserRepository().setUserAdmin(context,selectionUsers,true);
    if (response != null && response.status == 200) {
      SnackConst.SnackCustom("Utilisateur ajouté en tant qu'administrateur avec succés", context,
          duration: 3, color: Colors.green);
      Navigator.pop(context);
    }

    setState(() {
      _loaderButton = false;
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
          widget.globalData.company!.name,

          softWrap: true,
          overflow: TextOverflow.ellipsis,
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
                onChanged: (value) {
                  List<UserModel> filteredLibraries = searchListCompanyUser.where((library) {
                    return library.name.toLowerCase().contains(value.toLowerCase());
                  }).toList();

                  setState(() {
                    listCompanyUser = filteredLibraries;
                  });
                },
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
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
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                 if(!element.companyAdmin && widget.globalData.user.companyAdmin){
                                   if (selectionUsers.contains(element.uuid)) {
                                     selectionUsers.remove(element.uuid);
                                   } else {
                                     selectionUsers.add(element.uuid);
                                   }
                                 }
                                });
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Container(
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color:selectionUsers.contains(element.uuid) ? ColorConst.tertiary:  AppTheme.of(context).secondaryBackground,
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
                                            padding: EdgeInsets.only(right: 5.w),
                                            child: Container(
                                              width: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: element.profileUrl.isEmpty
                                                  ? Image.asset(
                                                      'assets/images/tlchargement.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      element.profileUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          Text(element.name + " " + element.lastname,

                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppTheme.of(context).primary,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          const Spacer(),
                                          if (uuidUser == element.uuid)
                                            Padding(
                                              padding: EdgeInsets.only(right: 5.w),
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
                                                      color:
                                                          AppTheme.of(context).secondaryBackground,
                                                      fontSize: 10.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (element.companyAdmin)
                                            Padding(
                                              padding: EdgeInsets.only(right: 5.w),
                                              child: Container(
                                                width: 50,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.of(context).secondary,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Admin",
                                                    style: TextStyle(
                                                      color:
                                                          AppTheme.of(context).secondaryBackground,
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
                                  )),
                            );
                },
              ),
            ),
          ),
          Visibility(
            visible: widget.globalData.user.companyAdmin,
              child: Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: CustomButton(
              text: "Ajouter en admin",
              isLoading: _loaderButton,
              disabled: selectionUsers.isEmpty,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Ajouter en admin"),
                      content: const Text(
                          "Voulez-vous vraiment ajouter ces utilisateurs en admin ?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            addAdmin();
                          },
                          child: const Text("Confirmer"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
