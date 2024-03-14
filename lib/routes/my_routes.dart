import 'package:flutter/material.dart';
import 'package:revision_resume_builder_app/pages/detail_page/detail_page.dart';
import 'package:revision_resume_builder_app/pages/home_page/home_page.dart';
import 'package:revision_resume_builder_app/pages/pdf_page/pdf_page.dart';

class MyRoutes {
  static String homePage = '/';
  static String detailPage = 'detail_page';
  static String pdfPage = 'pdf_page';
  static String buildOptionsPage = 'build_options_page';

  static Map<String, WidgetBuilder> routes = {
    homePage: (context) => const HomePage(),
    detailPage: (context) => const DetailPage(),
    pdfPage: (context) => const PdfPage(),
  };

  static List<Map<String, String>> buildOptionPages = [
    {
      'title': "Contact info",
      'icon': "assets/icons/contact.jpg",
      'route': "contact_info",
    },
    {
      'title': "Contact info",
      'icon': "assets/icons/contact.jpg",
      'route': "contact_info",
    },
    {
      'title': "Contact info",
      'icon': "assets/icons/contact.jpg",
      'route': "contact_info",
    },
    {
      'title': "Contact info",
      'icon': "assets/icons/contact.jpg",
      'route': "contact_info",
    },
  ];
}
