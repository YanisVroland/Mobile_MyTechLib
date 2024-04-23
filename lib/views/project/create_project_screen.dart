import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';
import 'package:my_tech_lib/services/models/library_model.dart';
import 'package:my_tech_lib/services/models/project_model.dart';
import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/icon_custom.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/alert_app.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/dropdown_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/repositories/project_repository.dart';

class CreateProjectWidget extends StatefulWidget {
  const CreateProjectWidget(this.library, {Key? key}) : super(key: key);
  final Library library;

  @override
  _CreateProjectWidgetState createState() => _CreateProjectWidgetState();
}

class _CreateProjectWidgetState extends State<CreateProjectWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> secondFormKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  bool _isFirstFormCollapsed = false;
  String selectedType = "";
  List<String> listeType = ["MOBILE", "WEB", "API"];
  bool _loader = false;
  List<String> imageList = ["", "", "", "", ""];
  String logoImage = "";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  validMobileButton(String projectUuid) async {
    if (logoImage != "") {
      await ProjectRepository().updateLogoProject(context, projectUuid, logoImage);
    }
    if (imageList.isNotEmpty) {
      await ProjectRepository().uploadIllustrations(context, projectUuid, imageList);
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Projet mobile créé avec succès"),
      backgroundColor: ColorConst.success,
    ));
    Navigator.pop(context);
  }

  validButton() async {
    setState(() {
      _loader = true;
    });
    Project project = Project(
        name: nameController.text,
        description: descriptionController.text,
        type: selectedType,
        core_library: widget.library.uuid,
        core_company: widget.library.core_company);

    ResponseApi? response =
        await ProjectRepository().createProject(context, project, widget.library);
    if (response != null && response.status == 201) {
      if (selectedType == "MOBILE") {
        await validMobileButton(response.body["uuid"]);
      } else if (selectedType == "WEB") {
      } else if (selectedType == "API") {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Projet mobile créé avec succès"),
          backgroundColor: ColorConst.success,
        ));
        Navigator.pop(context);
      }
    }
    setState(() {
      _loader = false;
    });
  }

  nextPart() {
    setState(() {
      _isFirstFormCollapsed = true;
    });
  }

  addPicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery, requestFullMetadata: false);
    if (!this.mounted) return;
    for (int i = 0; i < imageList.length; i++) {
      if (imageList[i] == "") {
        setState(() {
          imageList[i] = pickedFile!.path;
        });
        break;
      }
    }
  }

  Widget oneImageWidget(String e) => InkWell(
      onTap: () async {
        if (e == "") {
          addPicture();
        }
      },
      child: Row(
        children: [
          Stack(children: [
            Container(
              width: 90.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: ColorConst.background,
                borderRadius: BorderRadius.circular(20.0.r),
              ),
              child: e == ""
                  ? Center(
                      child: SvgPicture.asset(
                      "assets/icons/camera.svg",
                      width: 30.w,
                    ))
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Image.file(
                        File(e),
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(70),
                        height: ScreenUtil().setWidth(70),
                      )),
            ),
            Visibility(
                visible: e.isNotEmpty,
                child: InkWell(
                  child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2.r))),
                      child: SvgPicture.asset(
                        "assets/icons/close.svg",
                        width: 15.w,
                      )),
                  onTap: () {
                    Alerts.alert_image(context, () {
                      setState(() {
                        imageList[imageList.indexOf(e)] = "";
                      });
                    });
                  },
                ))
          ]),
          Container(width: 8.w)
        ],
      ));

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

    Widget secondFormMobileWidget = Form(
      key: secondFormKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.w),
              child: Center(
                child: Text("Projet Mobile",
                    style: TextStyle(
                        fontSize: 20.sp, color: ColorConst.primary, fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    "Logo :",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (logoImage == "") {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery, requestFullMetadata: false);
                      if (pickedFile != null) {
                        setState(() {
                          logoImage = pickedFile.path;
                        });
                      }
                    }
                  },
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      color: ColorConst.background,
                      borderRadius: BorderRadius.circular(20.0.r),
                    ),
                    child: logoImage == ""
                        ? Center(
                            child: SvgPicture.asset(
                              "assets/icons/camera.svg",
                              width: 30.w,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Image.file(
                              File(logoImage),
                              fit: BoxFit.cover,
                              width: ScreenUtil().setWidth(70),
                              height: ScreenUtil().setWidth(70),
                            )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                "carrousel d'images :",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.h),
              height: 100,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: imageList.map((e) => oneImageWidget(e)).toList()),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      text: 'Valider',
                      isLoading: _loader,
                      onTap: () async {
                        await validButton();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    Widget secondFormAPIWidget = Form(
      key: secondFormKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        child: Center(
          child: Text("API" + " " + "Form"),
        ),
      ),
    );

    Widget secondFormWEBWidget = Form(
      key: secondFormKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        child: Center(
          child: Text("WEB" + " " + "Form"),
        ),
      ),
    );

    Widget firstFormWidget = Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
          padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: CustomTextField(
                  controller: nameController,
                  labelText: "Nom",
                  hintText: "Entrer le nom du projet",
                  validator: Validators.validateEmpty,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: CustomTextField(
                  controller: descriptionController,
                  labelText: "Description",
                  hintText: "Entrer la description du projet",
                  validator: Validators.validateEmpty,
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: CustomDropDown(
                  hintText: "Type de projet",
                  listValue: listeType,
                  validator: Validators.validateDropDownEmpty,
                  action: (dynamic value) {
                    setState(() {
                      selectedType = value ?? "";
                    });
                  },
                  value: null,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        text: 'Continuer',
                        isLoading: _loader,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await nextPart();
                          }
                        }),
                  ],
                ),
              ),
            ],
          )),
    );

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).tertiary,
        body: SingleChildScrollView(
          child: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Nouveau projet",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: AppTheme.of(context).background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: IconCustom(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          buttonSize: 48.0,
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 30.0,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                    ),
                    child: AnimatedCrossFade(
                      duration: Duration(milliseconds: 500),
                      crossFadeState: _isFirstFormCollapsed
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: firstFormWidget,
                      secondChild: selectedType == "MOBILE"
                          ? secondFormMobileWidget
                          : selectedType == "WEB"
                              ? secondFormWEBWidget
                              : secondFormAPIWidget,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
