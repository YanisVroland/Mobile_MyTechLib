import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';

class CompanyEditWidget extends StatefulWidget {
  const CompanyEditWidget({Key? key}) : super(key: key);

  @override
  _CompanyEditWidgetState createState() => _CompanyEditWidgetState();
}

class _CompanyEditWidgetState extends State<CompanyEditWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;

  // State field(s) for TextField widget.
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  bool isDataUploading = false;
  String uploadedFileUrl = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
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
          child: Icon(
            Icons.arrow_back_ios,
            size: 24.0,
          ),
        ),
        title: Text(
          "Compagnie",
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                //TODO Navigation
                // context.pushNamed('profilePage');
              },
              child: Icon(
                Icons.settings,
                size: 26.0,
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 5.0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 2.0),
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(70.0),
                                topRight: Radius.circular(70.0),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Création"),
                                      Text(
                                        'd/M/y',
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context).secondaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          TextFormField(
                                            controller: textController1 ??= TextEditingController(
                                              text: "name",
                                            ),
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: "Nom",
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context).primary,
                                                  width: 2.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context).error,
                                                  width: 2.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context).error,
                                                  width: 2.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            validator: Validators.validateEmpty,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                            child: TextFormField(
                                              controller: textController2 ??= TextEditingController(
                                                text: "description",
                                              ),
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: "Description",
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppTheme.of(context).primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppTheme.of(context).error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                focusedErrorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppTheme.of(context).error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                              maxLines: 5,
                                              validator: Validators.validateEmpty,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                            child: CustomButton(
                                              text: "Modifier",
                                              onTap: () async {
                                                // await stackCompaniesRecord
                                                //     .reference
                                                //     .update(
                                                //         createCompaniesRecordData(
                                                //   name: _model
                                                //       .textController1.text,
                                                //   description: _model
                                                //       .textController2.text,
                                                // ));
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Informations mis à jour',
                                                      style: TextStyle(
                                                      ),
                                                    ),
                                                    duration: Duration(milliseconds: 4000),
                                                    backgroundColor: AppTheme.of(context).secondary,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // final selectedMedia = await selectMedia(
                                //   imageQuality: 60,
                                //   mediaSource: MediaSource.photoGallery,
                                //   multiImage: false,
                                // );
                                // if (selectedMedia != null &&
                                //     selectedMedia.every((m) =>
                                //         validateFileFormat(
                                //             m.storagePath, context))) {
                                //   setState(
                                //       () => isDataUploading = true);
                                //   var selectedUploadedFiles =
                                //       <FFUploadedFile>[];
                                //
                                //   var downloadUrls = <String>[];
                                //   try {
                                //     showUploadMessage(
                                //       context,
                                //       'Uploading file...',
                                //       showLoading: true,
                                //     );
                                //     selectedUploadedFiles = selectedMedia
                                //         .map((m) => FFUploadedFile(
                                //               name: m.storagePath
                                //                   .split('/')
                                //                   .last,
                                //           bytes: m.bytes,
                                //           height: m.dimensions?.height,
                                //           width: m.dimensions?.width,
                                //           blurHash: m.blurHash,
                                //         ))
                                //     .toList();
                                //
                                // downloadUrls = (await Future.wait(
                                //   selectedMedia.map(
                                //     (m) async => await uploadData(
                                //         m.storagePath, m.bytes),
                                //   ),
                                // ))
                                //     .where((u) => u != null)
                                //     .map((u) => u!)
                                //     .toList();
                                // } finally {
                                //   ScaffoldMessenger.of(context)
                                //       .hideCurrentSnackBar();
                                //   isDataUploading = false;
                                // }
                                // if (selectedUploadedFiles.length ==
                                //         selectedMedia.length &&
                                //     downloadUrls.length ==
                                //         selectedMedia.length) {
                                //   setState(() {
                                //       uploadedLocalFile =
                                //           selectedUploadedFiles.first;
                                //       uploadedFileUrl =
                                //           downloadUrls.first;
                                //     });
                                //     showUploadMessage(context, 'Success!');
                                //   } else {
                                //     setState(() {});
                                //     showUploadMessage(
                                //         context, 'Failed to upload data');
                                //     return;
                                //   }
                                // }
                                //
                                // if (uploadedFileUrl != null &&
                                //     uploadedFileUrl != '') {
                                //   await actions.deleteImage(
                                //     stackCompaniesRecord.urlPicture,
                                //   );
                                //
                                //   await stackCompaniesRecord.reference
                                //       .update(createCompaniesRecordData(
                                //     urlPicture: uploadedFileUrl,
                                //   ));
                                // }
                              },
                              child: Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x33000000),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(33.0),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://w7.pngwing.com/pngs/981/645/png-transparent-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette-symbol-thumbnail.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
