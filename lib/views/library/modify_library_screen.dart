import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';
import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/icon_custom.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/library_model.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/models/user_model.dart';
import '../../services/repositories/library_repository.dart';

class ModifyLibraryWidget extends StatefulWidget {
  ModifyLibraryWidget(this.user, this.library, {Key? key}) : super(key: key);
  final UserModel user;
  Library library;

  @override
  _ModifyLibraryWidgetState createState() => _ModifyLibraryWidgetState();
}

class _ModifyLibraryWidgetState extends State<ModifyLibraryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool toCompany = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  bool _loader = false;
  String logoImage = "";
  String bannerImage = "";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    initData();
  }

  initData() {
    if (widget.library!.logoUrl != null) {
      logoImage = widget.library!.logoUrl!;
    }
    if (widget.library!.bannerUrl != null) {
      bannerImage = widget.library!.bannerUrl!;
    }
    nameController.text = widget.library!.name;
    descriptionController.text = widget.library!.description;
    toCompany = !widget.library!.isPersonal!;
  }

  validButton() async {
    setState(() {
      _loader = true;
    });
    Library library = Library(
      uuid: widget.library.uuid,
      name: nameController.text,
      description: descriptionController.text,
      isPersonal: !toCompany,
      logoUrl: logoImage,
      bannerUrl: bannerImage,
    );
    if (!toCompany) {
      library.belongsTo = widget.user.uuid;
      library.core_company = null;
    } else {
      library.core_company = widget.user.companyUuid;
      library.belongsTo = '';
    }
    ResponseApi? response = await LibraryRepository().updateLibrary(context, library);

    if (response != null && response.status == 200) {
      Library newData = Library.fromJson(response.body);
      Navigator.pop(context,newData);
    }
    setState(() {
      _loader = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

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
                        "Modification Librairie",
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
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Container(
                            padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  controller: nameController,
                                  labelText: "Nom",
                                  hintText: "Entrer le nom de la librairie",
                                  validator: Validators.validateEmpty,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: CustomTextField(
                                    controller: descriptionController,
                                    labelText: "Description",
                                    hintText: "Entrer la description de la librairie",
                                    validator: Validators.validateEmpty,
                                    maxLines: 5,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 10.w),
                                              child: Text(
                                                "Logo :",
                                                style: TextStyle(fontSize: 16.sp),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                final pickedFile = await ImagePicker().pickImage(
                                                    source: ImageSource.gallery,
                                                    requestFullMetadata: false);
                                                if (pickedFile != null) {
                                                  setState(() {
                                                    logoImage = pickedFile.path;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: 50.w,
                                                height: 50.w,
                                                decoration: BoxDecoration(
                                                  color: ColorConst.background,
                                                  borderRadius: BorderRadius.circular(20.0.r),
                                                ),
                                                child: logoImage == ""
                                                    ? Center(
                                                        child: SvgPicture.asset(
                                                          "assets/icons/camera.svg",
                                                          width: 20.w,
                                                        ),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(12)),
                                                        child: logoImage.contains("http")
                                                            ? Image.network(
                                                                logoImage,
                                                                width: 50.w,
                                                                height: 50.w,
                                                                fit: BoxFit.cover,
                                                              )
                                                            : Image.file(
                                                                File(logoImage),
                                                                width: 50.w,
                                                                height: 50.w,
                                                                fit: BoxFit.cover,
                                                              ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 10.w),
                                              child: Text(
                                                "Bannière :",
                                                style: TextStyle(fontSize: 16.sp),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                final pickedFile = await ImagePicker().pickImage(
                                                    source: ImageSource.gallery,
                                                    requestFullMetadata: false);
                                                if (pickedFile != null) {
                                                  setState(() {
                                                    bannerImage = pickedFile.path;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: 80.w,
                                                height: 50.w,
                                                decoration: BoxDecoration(
                                                  color: ColorConst.background,
                                                  borderRadius: BorderRadius.circular(20.0.r),
                                                ),
                                                child: bannerImage == ""
                                                    ? Center(
                                                        child: SvgPicture.asset(
                                                          "assets/icons/camera.svg",
                                                          width: 20.w,
                                                        ),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(12)),
                                                        child: bannerImage.contains("http")
                                                            ? Image.network(
                                                                bannerImage,
                                                                width: 80.w,
                                                                height: 50.w,
                                                                fit: BoxFit.cover,
                                                              )
                                                            : Image.file(
                                                                File(bannerImage),
                                                                width: 80.w,
                                                                height: 50.w,
                                                                fit: BoxFit.cover,
                                                              ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Row(
                                      children: [
                                        Text("Librairie entreprise",
                                            style: TextStyle(color: Colors.black, fontSize: 16.sp)),
                                        Checkbox(
                                          value: toCompany,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              toCompany = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButton(
                                          text: 'Modifier',
                                          isLoading: _loader,
                                          onTap: () async {
                                            if (formKey.currentState!.validate()) {
                                              validButton();
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
