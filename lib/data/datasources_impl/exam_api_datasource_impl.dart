import 'dart:convert';

import 'package:answer_sheet_auditor/core/error/exceptions.dart';
import 'package:answer_sheet_auditor/core/utils/url.dart';
import 'package:answer_sheet_auditor/data/datasources/exam_api_datasource.dart';
import 'package:answer_sheet_auditor/data/models/exam_details_model.dart';
import 'package:answer_sheet_auditor/data/models/exam_model.dart';
import 'package:http/http.dart' as http;

class ExamAPIRemoteDataSourceImpl extends ExamAPIRemoteDataSource {
  ExamAPIRemoteDataSourceImpl(this.client);
  final http.Client client;

  @override
  Future<void> createExam(Map<String, dynamic> data, String token) async {
    try {
      const String url = URL.CREATE_EXAM_URL;
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final http.Response response =
          await client.post(url, body: jsonEncode(data), headers: headers);
      final int statusCode = response.statusCode;
      if (statusCode == 201) {
        return;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ExamsModel>> getAllExams(String token) async {
    try {
      const String url = URL.LIST_ALL_EXAMS_URL;
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final http.Response response = await client.get(url, headers: headers);
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        final List<ExamsModel> exams = examsModelFromJson(response.body);

        return exams;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ExamDetails> getExamsDetails(String token, int id) async {
    try {
      final String url = '${URL.VIEW_EXAM_URL}$id/';
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final http.Response response = await client.get(url, headers: headers);
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        final ExamDetails exams = examDetailsFromJson(response.body);
        return exams;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
