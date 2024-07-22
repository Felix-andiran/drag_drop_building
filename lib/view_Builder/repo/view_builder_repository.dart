import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:nitrite/nitrite.dart';

class ViewBuilderRepository {
  const ViewBuilderRepository();
  // final Nitrite _localDB;
  // static const String _collectionName = 'homeData';

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
      throw ProfileDataNotFoundException();
    }
  }

  // Insert home data to database
  // Future<void> saveProfileData(Map<String, dynamic> homeData) async {
  //   try {
  //     if (kDebugMode) {
  //       print('Attempting to save data...');
  //     }

  //     final NitriteCollection collection =
  //         await _localDB.getCollection(_collectionName);

  //     await collection.clear();
  //     if (kDebugMode) {
  //       print('Collection Data Cleared');
  //     }

  //     final Document document = documentFromMap(homeData);

  //     if (kDebugMode) {
  //       print('Data to be stored in local');
  //     }

  //     await collection.insert(document);

  //     if (kDebugMode) {
  //       print('Data inserted successfully.');
  //     }
  //   } on Exception catch (error) {
  //     if (kDebugMode) {
  //       print('>> Save HomeData Exception: $error');
  //     }
  //     throw ProfileDataSaveException();
  //   }
  // }

// Fetch home data from database
  // Future<Map<String, dynamic>?> fetchProfileDataFromDB() async {
  //   try {
  //     final NitriteCollection collection =
  //         await _localDB.getCollection(_collectionName);

  //     if (collection.size == 0) {
  //       if (kDebugMode) {
  //         print('No collection found in local database');
  //       }
  //       return null;
  //     }

  //     final Document? document = await collection.find().last;

  //     if (document == null) {
  //       if (kDebugMode) {
  //         print('No document found in local database');
  //       }
  //       return null;
  //     }

  //     if (kDebugMode) {
  //       print('Data fetched from local');
  //     }

  //     final Map<String, dynamic> data = convertDocumentToMap(document);
  //     return data;
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print('>> Fetch Profile Data Exception: $error');
  //     }
  //     return null; // In case of exception, return null
  //   }
  // }
}

class ProfileDataNotFoundException implements Exception {}

class ProfileDataSaveException implements Exception {}
