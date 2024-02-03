import 'package:dio/dio.dart';


class DioHelper{
  static late Dio dio;
  static late Dio dioForImage;

  static init()
  {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        headers: {
          "Content-Type": "application/json",
        },
        validateStatus: (_)=> true,
        connectTimeout: 1000,
        receiveTimeout: 1000,
        //  contentType: Headers.jsonContentType,
      ),
    );
    dioForImage = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        headers: {
          "Content-Type": "application/json",
        },
        responseType:ResponseType.bytes ,
        validateStatus: (_)=> true,
        connectTimeout: 1000,
        receiveTimeout: 1000,
        //  contentType: Headers.jsonContentType,
      ),
    );
  }

  static Future<Response> getData({
    required String url
  }) async
  {
    return await dio.get(
      url
    );
  }  static Future<Response> getImage({
    required String url
  }) async
  {
    return await dioForImage.get(
      url
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data
  }) async
  {

    return dio.post(
      url,
      data: data,
    );
  }

}