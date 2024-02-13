import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/button_custom.dart';

class NotificationsSettingsWidget extends StatefulWidget {
  const NotificationsSettingsWidget({Key? key}) : super(key: key);

  @override
  _NotificationsSettingsWidgetState createState() => _NotificationsSettingsWidgetState();
}

class _NotificationsSettingsWidgetState extends State<NotificationsSettingsWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue1;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left_rounded,
            size: 32.0,
          ),
        ),
        title: Text(
          "Notifications",
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: Image.asset(
              'assets/images/login_bg@2x.png',
            ).image,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      "Choisissez ci-dessous les notifications que vous souhaitez recevoir",
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: SwitchListTile.adaptive(
                value: switchListTileValue1 ??= true,
                onChanged: (newValue) async {
                  setState(() => switchListTileValue1 = newValue!);
                },
                title: Text("Notifications push"),
                subtitle: Text("Recevez des notifications Push"),
                tileColor: AppTheme.of(context).secondaryBackground,
                activeColor: AppTheme.of(context).tertiary,
                activeTrackColor: AppTheme.of(context).primary,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding: EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
              ),
            ),
            SwitchListTile.adaptive(
              value: switchListTileValue2 ??= true,
              onChanged: (newValue) async {
                setState(() => switchListTileValue2 = newValue!);
              },
              title: Text("Notifications par email"),
              subtitle: Text(
                "Recevez des notifications par email",
              ),
              tileColor: AppTheme.of(context).secondaryBackground,
              activeColor: AppTheme.of(context).tertiary,
              activeTrackColor: AppTheme.of(context).primary,
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding: EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: CustomButton(
                text: "Save Changes",
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
