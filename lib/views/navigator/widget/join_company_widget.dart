import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/app/theme/validators.dart';
import 'package:my_tech_lib/app/widgets/textField_custom.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/widgets/button_custom.dart';
import '../../../app/routes/router.dart';
import '../../../app/theme/snackBar_const.dart';
import '../../../services/models/company_model.dart';
import '../../../services/models/globalData_model.dart';
import '../../../services/models/information_model.dart';
import '../../../services/models/responseAPI_model.dart';
import '../../../services/repositories/company_repository.dart';
import '../../../services/repositories/information_repository.dart';

class JoinCompany extends StatefulWidget {
  JoinCompany(this.globalData, {Key? key}) : super(key: key);
  GlobalData globalData;

  @override
  _JoinCompanyState createState() => _JoinCompanyState();
}

class _JoinCompanyState extends State<JoinCompany> {
  late TextEditingController nameCompanyController;
  late TextEditingController descriptionCompanyController;
  late TextEditingController codeCompanyController;
  int filterIdx = 1;
  final _formNewKey = GlobalKey<FormState>();
  final _formJoinKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    nameCompanyController = TextEditingController();
    codeCompanyController = TextEditingController();
    descriptionCompanyController = TextEditingController();
  }

  validJoinAction() async {
    setState(() {
      _loading = true;
    });

    ResponseApi? responseApi =
        await CompanyRepository().joinCompany(context, codeCompanyController.text);
    if (responseApi != null && responseApi.status == 200) {
      if (responseApi.body['uuid'] != null) {
        await InformationRepository().createInformation(
            context,
            Information(
                core_company: responseApi.body['uuid'],
                type: "NEW",
                message: "${widget.globalData.user.name} ${widget.globalData.user.lastname} a rejoint l'entreprise"
            ));
      }
      await Navigator.pushNamed(context, AppRouter.MAIN, arguments: widget.globalData.user.uuid);
    }else{
      SnackConst.SnackCustom("Le code ne correspond à aucune entreprise", context, color: Colors.red);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameCompanyController.dispose();
    codeCompanyController.dispose();
    descriptionCompanyController.dispose();
  }

  validNewAction() async {
    setState(() {
      _loading = true;
    });

    Company company = Company(
      name: nameCompanyController.text,
      description: descriptionCompanyController.text,
    );

    ResponseApi? responseApi = await CompanyRepository().createCompany(context, company);
    if (responseApi != null && responseApi.status == 201) {
      await Navigator.pushNamed(context, AppRouter.MAIN, arguments: widget.globalData.user.uuid);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          filterIdx = 1;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: filterIdx == 1
                              ? AppTheme.of(context).primary
                              : AppTheme.of(context).background,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                          ),
                          border: Border.all(
                            color: filterIdx == 1
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).background,
                          ),
                        ),
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Align(
                          alignment: const AlignmentDirectional(0.00, 0.00),
                          child: Text(
                            "NOUVELLE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: filterIdx == 1 ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          filterIdx = 2;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: filterIdx == 2
                              ? AppTheme.of(context).primary
                              : AppTheme.of(context).background,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(20.0),
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(20.0),
                          ),
                          border: Border.all(
                            color: filterIdx == 2
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).background,
                          ),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0.00, 0.00),
                          child: Text(
                            "REJOINDRE",
                            style: TextStyle(
                              color: filterIdx == 2 ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            filterIdx == 1
                ? Form(
                    key: _formNewKey,
                    child: Column(
                      children: [
                        Text(
                          "Ajouter votre entreprise",
                          style: TextStyle(
                            color: AppTheme.of(context).primary,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: CustomTextField(
                            controller: nameCompanyController,
                            obscureText: false,
                            prefixIcon: const Icon(Icons.business_outlined),
                            validator: Validators.validateEmpty,
                            hintText: "Nom entreprise ...",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.h,
                            bottom: 40.h,
                          ),
                          child: CustomTextField(
                            controller: descriptionCompanyController,
                            labelText: "Description",
                            hintText: "Entrer la description de l'entreprise ...",
                            maxLines: 5,
                          ),
                        ),
                        CustomButton(
                          text: "Ajouter",
                          isLoading: _loading,
                          onTap: () {
                            if (_formNewKey.currentState!.validate()) {
                              validNewAction();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                : Form(
                    key: _formJoinKey,
                    child: Column(
                      children: [
                        Text(
                          "Rejoindre une entreprise",
                          style: TextStyle(
                            color: AppTheme.of(context).primary,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 40.h, top: 40.h),
                          child: CustomTextField(
                              controller: codeCompanyController,
                              obscureText: false,
                              prefixIcon: const Icon(Icons.lock_outlined),
                              validator: Validators.validateEmpty,
                              hintText: "Code entreprise ..."),
                        ),
                        CustomButton(
                          text: "Rejoindre",
                          isLoading: _loading,
                          onTap: () {
                            if (_formJoinKey.currentState!.validate()) {
                              validJoinAction();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
