import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class ApiCubit extends Cubit<List<String>> {
  ApiCubit() : super([]);

  final Dio _dio = Dio();

  Future<void> fetchQuotes() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );

      final List data = response.data;

      final posts = data.take(10).map<String>((item) {
        return item['title'];
      }).toList();

      emit(posts);
    } catch (e) {
      emit(['Failed to load API data']);
    }
  }
}