import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/services/models/library_model.dart';
import 'package:my_tech_lib/services/repositories/library_repository.dart';
import 'package:my_tech_lib/services/repositories/project_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/color_const.dart';
import '../../app/theme/snackBar_const.dart';
import '../../app/widgets/DeleteDialog_custom.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/icon_custom.dart';
import '../../services/models/mobileProject_model.dart';

class MobileWidget extends StatefulWidget {
  const MobileWidget(this.project, {Key? key}) : super(key: key);
  final MobileProject project;

  @override
  _MobileWidgetState createState() => _MobileWidgetState();
}

class _MobileWidgetState extends State<MobileWidget> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      SnackConst.SnackCustom('Impossible d\'ouvrir l\'URL $url', context,
          duration: 3, color: Colors.red);
    }
  }

  Future<void> deleteLibrary() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          title: "Supprimer le projet ?",
          content: "Etes-vous sûr de vouloir supprimer ?",
          onCancel: () {
            Navigator.of(context).pop();
          },
          onDelete: () async {
            await ProjectRepository().deleteProject(context,widget.project);
            await LibraryRepository().updateLibraryCountProject(context, widget.project.core_library);

            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: IconCustom(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30.0,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text("Projet MOBILE"),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.h,
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: AppTheme.of(context).primary,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: widget.project.logoUrl.isNotEmpty
                                  ? Image.network(
                                      widget.project.logoUrl,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/tlchargement.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.project.name,
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: AppTheme.of(context).primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (widget.project.companyName != null)
                                      Text(
                                        widget.project.companyName!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  widget.project.version,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: PopupMenuButton<String>(
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        onTap: () async {
                                          // Object? newData = await Navigator.pushNamed(
                                          //     context, AppRouter.MODIFY_LIBRARY,
                                          //     arguments: [widget.user, widget.library]);
                                          // if (newData != null) {
                                          //   setState(() {
                                          //     widget.library = newData as Library;
                                          //   });
                                          // }
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(Icons.edit),
                                            Text('Modifier'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        textStyle: const TextStyle(color: Colors.red),
                                        onTap: deleteLibrary,
                                        child: const Row(
                                          children: [
                                            Icon(Icons.delete, color: Colors.red),
                                            Text('Supprimer', style: TextStyle(color: Colors.red)),
                                          ],
                                        ),
                                      ),
                                    ],
                                    child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: ColorConst.secondary,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: const Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (widget.project.platform.isNotEmpty)
                                      Row(
                                        children: [
                                          if (widget.project.platform == "ANDROID" ||
                                              widget.project.platform == "LES DEUX")
                                            IconCustom(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 30.0,
                                              icon: const Icon(
                                                Icons.android,
                                                color: Colors.green,
                                                size: 30.0,
                                              ),
                                              onPressed: () {},
                                            ),
                                          if (widget.project.platform == "IOS" ||
                                              widget.project.platform == "LES DEUX")
                                            IconCustom(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 30.0,
                                              icon: const Icon(
                                                Icons.apple,
                                                color: Colors.blue,
                                                size: 30.0,
                                              ),
                                              onPressed: () {},
                                            ),
                                        ],
                                      ),
                                    Visibility(
                                      visible: widget.project.apkUrl.isNotEmpty,
                                      child: CustomButton(
                                        text: "Télécharger",
                                        textStyle:
                                            const TextStyle(fontSize: 12, color: Colors.white),
                                        width: 100,
                                        height: 25,
                                        onTap: () async {
                                           _launchURL(Uri.parse(widget.project.apkUrl!));
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
                Visibility(
                  visible: widget.project.illustrationsUrl.isNotEmpty,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    height: 175,
                    width: double.infinity,
                    child: CarouselSlider(
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                        ),
                        items: widget.project.illustrationsUrl.map((imageUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList()),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description :",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: AppTheme.of(context).primary,
                              fontWeight: FontWeight.w600,
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 5.w, top: 5.h),
                            child: Text(widget.project.description,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ))),
                      ],
                    )),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    "Informations :",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: AppTheme.of(context).primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: widget.project.versionOS.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Version minimale nécessaire :",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Text(
                                  widget.project.versionOS,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.project.frameworkUsed.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Framework/librairie utilisé :",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Text(
                                  widget.project.frameworkUsed,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
