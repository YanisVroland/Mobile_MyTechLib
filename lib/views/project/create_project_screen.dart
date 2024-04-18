import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/services/models/library_model.dart';
import 'package:my_tech_lib/services/models/project_model.dart';
import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/icon_custom.dart';
import '../../app/theme/validators.dart';
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
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  String selectedType = "";
  List<String> listeType = ["MOBILE", "WEB", "API"];
  bool _loader = false;

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

  validButton() async {
    setState(() {
      _loader = true;
    });
    ProjectRepository libraryRepository = ProjectRepository();
    Project project = Project(
        name: nameController.text,
        description: descriptionController.text,
        type: selectedType,
        core_library: widget.library.uuid,
        core_company: widget.library.core_company);

    ResponseApi? response = await libraryRepository.createProject(context, project,widget.library);

    if (response != null && response.status == 201) {
      Navigator.pop(context);
    }
    setState(() {
      _loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget formWidget = Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
          padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(
                controller: nameController,
                labelText: "Nom",
                hintText: "Entrer le nom du projet",
                validator: Validators.validateEmpty,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: CustomTextField(
                  controller: descriptionController,
                  labelText: "Description",
                  hintText: "Entrer la description du projet",
                  validator: Validators.validateEmpty,
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: CustomDropDown(
                  hintText: "Type de projet",
                  listValue:  listeType,
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
                        text: 'Ajouter',
                        isLoading: _loader,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await validButton();
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
                      child: formWidget),
                ),
              ],
            ),
          ),
        ));
  }
}
