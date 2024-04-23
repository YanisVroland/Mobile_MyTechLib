import 'package:my_tech_lib/views/project/widget/mobile_widget.dart';

import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/icon_custom.dart';
import '../../services/models/project_model.dart';

class ProjectWidget extends StatefulWidget {
  const ProjectWidget(this.project, {Key? key}) : super(key: key);
  final Project project;

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final unfocusNode = FocusNode();

  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;


  @override
  void initState() {
    super.initState();

    tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();

    super.dispose();
  }

  getTypeName(){
    switch(widget.project.type) {
      case 'MOBILE':
        return 'Application Mobile';
      case 'WEB':
        return 'Site Web';
      case 'API':
        return 'API';
      default:
        return '???';
    }
  }



  @override
  Widget build(BuildContext context) {
    Widget initPage(){
      switch(widget.project.type) {
        case 'MOBILE':
          return MobileWidget(widget.project);
        case 'WEB':
          return MobileWidget(widget.project);
        case 'API':
          return MobileWidget(widget.project);
        default:
          return Container();
      }

    }

    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: IconCustom(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 30.0,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title:  Text(getTypeName()),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: initPage(),
        ),
      ),
    );
  }
}
