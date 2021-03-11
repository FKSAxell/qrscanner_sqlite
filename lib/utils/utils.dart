
import 'package:flutter/cupertino.dart';
import 'package:qrscanner_sqlite/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';


void launchURL(BuildContext context,ScanModel scan) async {
  final url = scan.valor;
  if(scan.tipo == 'http'){
    //abrir el sitio web
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }else{
    Navigator.pushNamed(context, 'mapa',arguments: scan);
  }
}
    