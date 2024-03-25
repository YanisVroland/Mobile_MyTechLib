import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

import '../../../app/theme/validators.dart';
import '../../../app/widgets/button_custom.dart';
import '../../../app/widgets/textField_custom.dart';
import '../../../services/models/library_model.dart';
import '../../../services/models/responseAPI_model.dart';
import '../../../services/models/user_model.dart';
import '../../../services/repositories/library_repository.dart';

class CreateCompanyLibraryWidget extends StatefulWidget {
  const CreateCompanyLibraryWidget(this.user,{Key? key}) : super(key: key);
  final UserModel user;

  @override
  _CreateCompanyLibraryWidgetState createState() => _CreateCompanyLibraryWidgetState();
}

class _CreateCompanyLibraryWidgetState extends State<CreateCompanyLibraryWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
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
    LibraryRepository libraryRepository = LibraryRepository();
    Library library = Library(
      name: nameController.text,
      description: descriptionController.text,
      core_company: widget.user.companyUuid,
      isPersonal: false,);
    ResponseApi? response = await libraryRepository.createLibrary(context, library);

    if (response != null && response.status == 201) {
      Navigator.pop(context);
    }
    setState(() {
      _loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                hintText: "Entrer le nom de la librairie",
                validator: Validators.validateEmpty,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: CustomTextField(
                  controller: descriptionController,
                  labelText: "Description",
                  hintText: "Entrer la description de la librairie",
                  validator: Validators.validateEmpty,
                  maxLines: 5,
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
  }
}

