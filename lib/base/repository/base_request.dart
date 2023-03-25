import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_application_3/core/values/url_strings.dart';

import '../../core/values/const.dart';
import '../controller/src_controller.dart';

enum RequestMethod { POST, GET, PUT, DELETE, PATCH }

class BaseRequest {
  static Dio dio = getBaseDio();

  static Dio getBaseDio() {
    Dio dio = Dio();

    dio.options = buildDefaultOptions();

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  static BaseOptions buildDefaultOptions() {
    return BaseOptions()
      ..connectTimeout = const Duration(milliseconds: AppConst.requestTimeOut)
      ..receiveTimeout = const Duration(milliseconds: AppConst.requestTimeOut);
  }

  static void close() {
    dio.close(force: true);
    updateCurrentDio();
  }

  static void updateCurrentDio() {
    dio = getBaseDio();
  }

  static Dio getCurrentDio() {
    return dio;
  }

  void setOnErrorListener(Function(Object error) onErrorCallBack) {
    this.onErrorCallBack = onErrorCallBack;
  }

  late Function(Object error) onErrorCallBack;

  /// [isQueryParametersPost]: `true`: phương thức post gửi params, mặc định = `false`
  ///
  /// [dioOptions]: option của Dio() sử dụng khi gọi api có option riêng
  ///
  /// [functionError]: chạy function riêng khi request xảy ra Exception (mặc định sử dụng [showDialogError])
  Future<dynamic> sendRequest(String action, RequestMethod requestMethod,
      {dynamic jsonMap,
      bool isDownload = false,
      String? urlOther,
      Map<String, String>? headersUrlOther,
      bool isQueryParametersPost = false,
      required BaseGetxController controller,
      BaseOptions? dioOptions,
      Function(Object error)? functionError}) async {
    dio.options = dioOptions ?? buildDefaultOptions();

    var response;
    String url = urlOther ?? ApiUrl.urlBase;
    //(AppConst.getUrlBase(HIVE_APP.get(AppConst.keyTaxCodeCompany)) + action);
    Map<String, String> headers = headersUrlOther ?? {};
    // headersUrlOther ?? await getBaseHeader(describeEnum(requestMethod));
    Options options = isDownload
        ? Options(
            headers: headers,
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status != null && status < 500;
            })
        : Options(
            headers: headers,
            method: requestMethod.toString(),
            responseType: ResponseType.json,
          );

    CancelToken _cancelToken = CancelToken();
    controller.addCancelToken(_cancelToken);
    try {
      if (requestMethod == RequestMethod.POST) {
        if (isQueryParametersPost) {
          response = await dio.post(
            url,
            queryParameters: jsonMap,
            options: options,
            cancelToken: _cancelToken,
          );
        } else {
          response = await dio.post(
            url,
            data: jsonMap,
            options: options,
            cancelToken: _cancelToken,
          );
        }
      } else if (requestMethod == RequestMethod.PUT) {
        response = await dio.put(
          url,
          data: jsonMap,
          options: options,
          cancelToken: _cancelToken,
        );
      } else if (requestMethod == RequestMethod.DELETE) {
        response = await dio.delete(
          url,
          data: jsonMap,
          options: options,
          cancelToken: _cancelToken,
        );
      } else if (requestMethod == RequestMethod.PATCH) {
        response = await dio.patch(
          url,
          data: jsonMap,
          options: options,
          cancelToken: _cancelToken,
        );
      } else {
        response = await dio.get(
          url,
          queryParameters: jsonMap,
          options: options,
          cancelToken: _cancelToken,
        );
      }
      return response.data;
    } catch (e) {
      controller.cancelRequest(_cancelToken);

      return functionError != null ? functionError(e) : showDialogError(e);
    }
  }

  dynamic showDialogError(dynamic e) {
    if (e.response?.data != null &&
        e.response.data is Map &&
        e.response.data["Data"] != null) return e.response.data;
    onErrorCallBack(e);
  }

  // Future<Map<String, String>> getBaseHeader(String httpMethod) async {
  //   String authentication = await getAuthentication(httpMethod);
  //   return {
  //     "Content-Type": "application/json",
  //     // 'Admin-Agent': 'iinvoice.vn',
  //     'Authentication': authentication,
  //     'TaxCode':
  //         await HIVE_APP.get(AppConst.keyTaxCodeCompany, defaultValue: ''),
  //   };
  // }

  ///
  /// @params username: login username store in Hive
  /// @params password: login password store in Hive
  /// @params timestamp: current milliseconds
  /// @params nonce: random 32 characters between [a-A,0-9]
  /// @params signature: base64Encode of md5 (httpMethod + timeStamp + nonce)
  ///
  // Future<String> getAuthentication(String httpMethod) async {
  //   String username =
  //       '${HIVE_CONFIG.get(HIVE_APP.get(AppConst.keyTaxCodeCompany) ?? "")?.userName ?? ""}';
  //   String password =
  //       '${HIVE_CONFIG.get(HIVE_APP.get(AppConst.keyTaxCodeCompany) ?? "")?.password ?? ""}';

  //   String timeStamp =
  //       (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  //   String nonce = _makeId();
  //   String signatureRawData =
  //       httpMethod.toUpperCase() + timeStamp + nonce.toString();
  //   String signature =
  //       base64Encode(crypto.md5.convert((utf8.encode(signatureRawData))).bytes);
  //   return "$signature:$nonce:$timeStamp:$username:$password";
  // }

  // String _makeId() {
  //   StringBuffer text = StringBuffer();
  //   String possible =
  //       "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  //   for (int i = 0; i <= 32; i++)
  //     text.write(possible[Random().nextInt(possible.length)]);
  //   return text.toString();
  // }
}
