import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ViewBuilderRepository {
  const ViewBuilderRepository();


  Future<Map<String, dynamic>> getViewJsonData() async {
    try {
      final response =
          await rootBundle.loadString('assets/data/profile_view.json');
      final data = jsonDecode(response) as Map<String, dynamic>;
      return data;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('>> Get Profile Exception $error');
      }
      throw ViewBuilderDataNotFoundException();
    }
  }
}

class ViewBuilderDataNotFoundException implements Exception {}


