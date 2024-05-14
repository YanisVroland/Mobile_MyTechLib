import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';
import 'package:my_tech_lib/services/models/mobileProject_model.dart';
import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/validators.dart';
import '../../../app/widgets/alert_app.dart';
import '../../../app/widgets/button_custom.dart';
import '../../../app/widgets/dropdown_custom.dart';
import '../../../app/widgets/icon_custom.dart';
import '../../../app/widgets/textField_custom.dart';
import '../../../services/models/apiProject_model.dart';
import '../../../services/models/responseAPI_model.dart';
import '../../../services/repositories/project_repository.dart';

class ApiModifyProjectWidget extends StatefulWidget {
  ApiModifyProjectWidget(this.project, {Key? key}) : super(key: key);
  ApiProject project;

  @override
  _ModifyProjectWidgetState createState() => _ModifyProjectWidgetState();
}

class _ModifyProjectWidgetState extends State<ApiModifyProjectWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> secondFormKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  bool _isFirstFormCollapsed = false;

  bool _loader = false;
  List<String> imageList = ["", "", "", "", ""];
  String logoImage = "";

  late TextEditingController frameworkController;
  late TextEditingController documentationController;
  late TextEditingController typeApiController;
  late TextEditingController dataFormatController;
  late TextEditingController authUsedController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    frameworkController = TextEditingController();
    documentationController = TextEditingController();
    typeApiController = TextEditingController();
    dataFormatController = TextEditingController();
    authUsedController = TextEditingController();

    initData();
  }

  initData() {
    nameController.text = widget.project.name;
    descriptionController.text = widget.project.description;
    frameworkController.text = widget.project.frameworkUsed;
    logoImage = widget.project.logoUrl;
    documentationController.text = widget.project.documentationUrl;
    typeApiController.text = widget.project.typeApi;
    dataFormatController.text = widget.project.dataFormat;
    authUsedController.text = widget.project.authUsed;
    for (int i = 0; i < widget.project.illustrationsUrl.length; i++) {
      imageList[i] = widget.project.illustrationsUrl[i];
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    frameworkController.dispose();
    documentationController.dispose();
    typeApiController.dispose();
    dataFormatController.dispose();
    authUsedController.dispose();
  }

  validButton() async {
    setState(() {
      _loader = true;

      widget.project.name = nameController.text;
      widget.project.description = descriptionController.text;
      widget.project.frameworkUsed = frameworkController.text;
      widget.project.documentationUrl = documentationController.text;
      widget.project.typeApi = typeApiController.text;
      widget.project.dataFormat = dataFormatController.text;
      widget.project.authUsed = authUsedController.text;
    });

    if (imageList.isNotEmpty) {
      for (int i = 0; i < imageList.length; i++) {
        if (imageList[i].isNotEmpty && imageList[i].contains("http") == false) {
          ResponseApi? response = await ProjectRepository()
              .uploadOneIllustration(context, widget.project.uuid, imageList[i], i);
          if (response != null && response.status == 201) {
            imageList[i] = response.body["url"];
          }
        }
      }
      setState(() {
        widget.project.illustrationsUrl = imageList;

      });
    }

    ResponseApi? response = await ProjectRepository().updateProject(context, widget.project);
    if (response != null && response.status == 200) {
      if (logoImage.isNotEmpty && logoImage.contains("http") == false) {
        await ProjectRepository().updateLogoProject(context, widget.project.uuid, logoImage);
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Projet mis à jour avec succès"),
        backgroundColor: ColorConst.success,
      ));
      Navigator.pop(context);
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

  Widget oneImageWidget(String e, int index) => Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: Stack(children: [
          Container(
            width: 90.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: ColorConst.background,
              borderRadius: BorderRadius.circular(20.0.r),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: e.isEmpty
                    ? Center(
                        child: Text((index + 1).toString(),
                            style: TextStyle(color: ColorConst.primary)))
                    : e.contains("http")
                        ? Image.network(
                            e,
                            width: 50.w,
                            height: 50.w,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2.r))),
                    child: SvgPicture.asset(
                      "assets/icons/close.svg",
                      width: 15.w,
                    )),
                onTap: () {
                  Alerts.alert_image(context, () {
                    setState(() {
                      imageList[index] = "";
                    });
                  });
                },
              ))
        ]),
      );

  Widget illustrationsWidget() {
    return SizedBox(
        height: 70.w,
        child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children:
                imageList.asMap().entries.map((e) => oneImageWidget(e.value, e.key)).toList()));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

    Widget secondFormAPIWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20.w),
          child: Center(
            child: Text("Projet API",
                style: TextStyle(
                    fontSize: 20.sp, color: ColorConst.primary, fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: typeApiController,
            labelText: "Type d'API",
            hintText: "RESTful, GraphQL, SOAP, etc.",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: documentationController,
            labelText: "Url de la documentation",
            hintText: "https://www.documentation.com",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: frameworkController,
            labelText: "Framework utilisé",
            hintText: "React Native, Flutter, Swift, etc.",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: dataFormatController,
            labelText: "Formats de données",
            hintText: "JSON, XML, etc.",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: authUsedController,
            labelText: "Authentification et autorisation ",
            hintText: "OAuth, JWT, Basic Auth, etc.",
          ),
        ),

      ],
    );

    Widget firstFormWidget = Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
        padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10.w,
                    ),
                    child: Text(
                      "Logo :",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery, requestFullMetadata: false);
                        if (pickedFile != null) {
                          setState(() {
                            logoImage = pickedFile.path;
                          });
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
                              child: logoImage.contains("http")
                                  ? Image.network(
                                      logoImage,
                                      width: 50.w,
                                      height: 50.w,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(logoImage),
                                      fit: BoxFit.cover,
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setWidth(70),
                                    )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: Text(
                            "Carrousel d'images :",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                        Text(
                          "${imageList.where((file) => file.isNotEmpty).length}",
                          style: TextStyle(
                              fontSize: 16.sp, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "/5",
                          style: TextStyle(
                              fontSize: 16.sp, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r),
                        // color: Colors.green.withOpacity(0.2),
                        color: ColorConst.tertiary.withOpacity(0.2),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        onPressed: () async {
                          List<XFile> pickedFile = await ImagePicker()
                              .pickMultiImage(requestFullMetadata: false, imageQuality: 50);

                          if (pickedFile != null) {
                            for (var i = 0; i < 5; i++) {
                              for (int j = 0; j < imageList.length; j++) {
                                if (imageList[j] == "") {
                                  setState(() {
                                    imageList[j] = pickedFile[i].path;
                                  });
                                  break;
                                }
                              }
                            }
                          }
                        },
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: illustrationsWidget(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      text: 'Continuer',
                      isLoading: _loader,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await nextPart();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
        key: _scaffoldKey,
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
                        "Modification projet",
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
                        secondChild: Form(
                          key: secondFormKey,
                          child: Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w, bottom: 20.h),
                            child: Column(
                              children: [
                                secondFormAPIWidget,
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
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
                                const Text('Les champs ne sont pas obligatoires',
                                    style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
