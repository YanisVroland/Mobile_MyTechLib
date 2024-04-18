import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyWidgetState createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      backgroundColor: AppTheme.of(context).background,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).background,
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left_rounded,
            size: 32.0,
          ),
        ),
        title: const Text(
          "Politique de confidentialité",
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0, 0.0, 30.0),
                  child: Text(
                    "Dernière mise à jour : 18/04/2024",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Text(
                    "Cette Politique de confidentialité décrit comment MyTechLib collecte, utilise et partage les informations personnelles des utilisateurs de l'application mobile.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Informations collectées",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                  child: Text(
                    "Lorsque vous utilisez l'Application, nous collectons automatiquement certaines informations sur votre appareil, y compris des informations sur votre navigateur web, votre système d'exploitation, votre adresse IP, votre fournisseur de services Internet, et d'autres données similaires. De plus, lorsque vous utilisez l'Application, nous pouvons collecter des informations sur les actions que vous effectuez dans l'Application, telles que les pages que vous consultez et les fonctionnalités que vous utilisez. Ces informations peuvent être associées à votre identifiant unique de l'appareil afin de vous fournir une expérience personnalisée et de suivre l'utilisation de l'Application. Nous ne collectons aucune information personnelle identifiable à votre sujet à moins que vous ne choisissiez de nous les fournir volontairement. Les informations personnelles que nous pouvons collecter comprennent votre nom, votre adresse e-mail, votre numéro de téléphone, et toute autre information que vous choisissez de nous fournir.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Utilisation des informations",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Les informations que nous collectons sont utilisées dans le but de fournir et d'améliorer l'Application. Ces informations sont également utilisées pour vous contacter au sujet de l'Application et de ses mises à jour, répondre à vos demandes et vous fournir un support technique lorsque cela est nécessaire.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Partage des informationss",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Nous ne partagerons pas vos informations personnelles avec des tiers sauf dans les cas suivants :\n    -Lorsque cela est nécessaire pour fournir ou améliorer l'Application ;\n    -Lorsque cela est requis par la loi ou par une autorité gouvernementale ;\n   -Lorsque cela est nécessaire pour protéger nos droits, notre propriété ou notre sécurité, ainsi que ceux de nos utilisateurs ou du public ;\n   -Avec votre consentement.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Conservation des données",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Nous conserverons vos informations personnelles aussi longtemps que nécessaire pour remplir les finalités décrites dans cette Politique de confidentialité, sauf si une période de conservation plus longue est requise ou autorisée par la loi.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Sécurité",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Nous prenons des mesures pour protéger vos informations personnelles contre la perte, le vol, l'accès non autorisé, la divulgation, la modification ou la destruction. Cependant, veuillez noter qu'aucune méthode de transmission sur Internet, ou méthode de stockage électronique, n'est 100% sécurisée. Par conséquent, bien que nous nous efforcions d'utiliser des moyens commercialement acceptables pour protéger vos informations personnelles, nous ne pouvons pas garantir leur sécurité absolue.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Modifications apportées à cette Politique de confidentialité",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Nous nous réservons le droit de mettre à jour ou de modifier notre Politique de confidentialité à tout moment et vous devriez la consulter périodiquement. Votre utilisation continue de l'Application après la publication de toute modification de la Politique de confidentialité constituera votre acceptation de ces modifications.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Contactez-nous",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    "Si vous avez des questions ou des préoccupations concernant cette Politique de confidentialité, veuillez nous contacter à l'adresse suivante : yanis@mytechlib.com",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
