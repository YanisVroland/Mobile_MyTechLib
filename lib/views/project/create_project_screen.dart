import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';
import 'package:my_tech_lib/services/models/library_model.dart';
import 'package:my_tech_lib/services/models/mobileProject_model.dart';
import 'package:my_tech_lib/services/models/project_model.dart';
import 'package:my_tech_lib/services/models/webProject_model.dart';
import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/icon_custom.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/alert_app.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/dropdown_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/apiProject_model.dart';
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
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> secondFormKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  bool _isFirstFormCollapsed = false;
  String selectedType = "";
  List<String> listeType = ["MOBILE", "WEB", "API"];

  bool _loader = false;
  List<String> imageList = ["", "", "", "", ""];
  String logoImage = "";

  //MOBILE
  String platform = "";
  List<String> listePlatform = ["IOS", "ANDROID", "LES DEUX"];
  late TextEditingController versionOsController;
  String apkFile = "";

  //WEB
  late TextEditingController urlWebController;
  late TextEditingController typeWebController;
  late TextEditingController frameworkController;
  late TextEditingController bddController;
  late TextEditingController hostingController;
  late TextEditingController securityController;

  //API
  late TextEditingController documentationController;
  late TextEditingController typeApiController;
  late TextEditingController dataFormatController;
  late TextEditingController authUsedController;

  @override
  void initState() {
    super.initState();
    versionOsController = TextEditingController();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    urlWebController = TextEditingController();
    typeWebController = TextEditingController();
    frameworkController = TextEditingController();
    bddController = TextEditingController();
    hostingController = TextEditingController();
    securityController = TextEditingController();
    typeApiController = TextEditingController();
    dataFormatController = TextEditingController();
    authUsedController = TextEditingController();
    documentationController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    versionOsController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    urlWebController.dispose();
    typeWebController.dispose();
    frameworkController.dispose();
    bddController.dispose();
    hostingController.dispose();
    securityController.dispose();
    typeApiController.dispose();
    documentationController.dispose();
    dataFormatController.dispose();
    authUsedController.dispose();
  }

  validButton() async {
    setState(() {
      _loader = true;
    });

    Project? project;

    if (selectedType == "MOBILE") {
      project = MobileProject(
          name: nameController.text,
          description: descriptionController.text,
          type: selectedType,
          platform: platform,
          versionOS: versionOsController.text,
          frameworkUsed: frameworkController.text,
          core_library: widget.library.uuid,
          core_company: widget.library.core_company);
    } else if (selectedType == "WEB") {
      project = WebProject(
          name: nameController.text,
          description: descriptionController.text,
          type: selectedType,
          urlWeb: urlWebController.text,
          typeWeb: typeWebController.text,
          frameworkUsed: frameworkController.text,
          bddUsed: bddController.text,
          hostingUsed: hostingController.text,
          securityUsed: securityController.text,
          core_library: widget.library.uuid,
          core_company: widget.library.core_company);
    } else if (selectedType == "API") {
      project = ApiProject(
          name: nameController.text,
          description: descriptionController.text,
          type: selectedType,
          frameworkUsed: frameworkController.text,
          dataFormat: dataFormatController.text,
          authUsed: authUsedController.text,
          typeApi: typeApiController.text,
          documentationUrl: documentationController.text,
          core_library: widget.library.uuid,
          core_company: widget.library.core_company);
    } else {
      project = Project(
          name: nameController.text,
          description: descriptionController.text,
          type: selectedType,
          core_library: widget.library.uuid,
          core_company: widget.library.core_company);
    }

    if (project == null) {
      setState(() {
        _loader = false;
      });
      return;
    }

    project.isPersonal = widget.library.core_company == null || widget.library.core_company!.isEmpty;

    ResponseApi? response =
        await ProjectRepository().createProject(context, project, widget.library);
    if (response != null && response.status == 201) {
      if (logoImage.isNotEmpty) {
        await ProjectRepository().updateLogoProject(context, response.body["uuid"], logoImage);
      }
      if (imageList.isNotEmpty && imageList.where((element) => element.isNotEmpty).isNotEmpty) {
        await ProjectRepository().uploadIllustrations(context, response.body["uuid"], imageList);
      }
      if (apkFile.isNotEmpty) {
        await ProjectRepository().updateApkProject(context, response.body["uuid"], apkFile);
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Projet créé avec succès"),
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

  openFileExplorer(BuildContext context) async {
    FilePickerResult? filePath = await FilePicker.platform.pickFiles();

    if (filePath != null) {
      setState(() {
        apkFile = filePath.files.single.path!;
      });
    }
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

    Widget secondFormMobileWidget = Column(
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
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomDropDown(
            hintText: "Plateforme cible",
            listValue: listePlatform,
            validator: Validators.validateDropDownEmpty,
            action: (dynamic value) {
              setState(() {
                platform = value ?? "";
              });
            },
            value: null,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: versionOsController,
            labelText: "Version minimale du mobile",
            hintText: "Par exemple, iOS 12, Android 8.0, etc",
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
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.shade300,
        ),
        Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("APK du projet :"),
                ElevatedButton(
                  onPressed: () => openFileExplorer(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sélectionner un fichier',
                          style: TextStyle(
                              fontSize: 10.sp, color: apkFile.isEmpty ? null : Colors.green)),
                      apkFile.isEmpty
                          ? Icon(Icons.upload_file, size: 18.w)
                          : Icon(Icons.check, color: Colors.green, size: 18.w),
                    ],
                  ),
                ),
              ],
            )),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.shade300,
        ),
      ],
    );

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

    Widget secondFormWEBWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20.w),
          child: Center(
            child: Text("Projet WEB",
                style: TextStyle(
                    fontSize: 20.sp, color: ColorConst.primary, fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: urlWebController,
            labelText: "Url du site",
            hintText: "https://www.example.com",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: typeWebController,
            labelText: "Type de site",
            hintText: "Site statique, site dynamique, application web progressive (PWA), etc",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: frameworkController,
            labelText: "Framework utilisé",
            hintText: "Angular, React.js, Vue.js, etc.",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: bddController,
            labelText: "Base de données",
            hintText: "MySQL, PostgreSQL, MongoDB, etc.",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: hostingController,
            labelText: "Hébergement",
            hintText: "Cloud (AWS, Azure, etc.), serveur dédié, etc.",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomTextField(
            controller: securityController,
            labelText: "Sécurité : ",
            hintText:
                "SSL, authentification, autorisation, protection contre les attaques CSRF, XSS, etc.",
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
                        secondChild: Form(
                          key: secondFormKey,
                          child: Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w, bottom: 20.h),
                            child: Column(
                              children: [
                                selectedType == "MOBILE"
                                    ? secondFormMobileWidget
                                    : selectedType == "WEB"
                                        ? secondFormWEBWidget
                                        : secondFormAPIWidget,
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
