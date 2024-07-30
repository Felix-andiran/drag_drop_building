import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class TemplateRepository {
  TemplateRepository();

  Logger log = Logger();

  Future<Map<String, dynamic>> getTemplateOneJsonData(String template) async {
    try {
      final response = await rootBundle.loadString('data/template_one.json');
      final data = jsonDecode(response) as Map<String, dynamic>;
      return data;
    } on Exception catch (error) {
      log.e('>> Get Template one Exception ::: $error');
      throw TemplateNotFoundException();
    }
  }
}

class TemplateNotFoundException implements Exception {}
