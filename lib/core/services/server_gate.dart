import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctorin/core/routes/app_routes_fun.dart';
import 'package:doctorin/core/routes/routes.dart';
import 'package:doctorin/core/widgets/flash_helper.dart';
import 'package:doctorin/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/user_model.dart';
import '../utils/enums.dart';
import '../utils/logger.dart';

class ServerGate {
  String? _baseUrl = 'https://doctor-in.sharqawi.aait-d.com/api';

  Map<String, dynamic> get constHeader => {
    if (UserModel.i.token.isNotEmpty)
      "Authorization": "Bearer ${UserModel.i.token}",
    "Accept": "application/json",
    "Accept-Language": LocaleKeys.lang.tr(),
  };

  final _dio = Dio();

  ServerGate._() {
    _dio.interceptors.add(CustomApiInterceptor());
  }

  static final ServerGate i = ServerGate._();

  Future<CustomResponse> sendToServer<T>({
    required String url,
    bool removeConstHeaders = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? formData,
    Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      body?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      formData?.removeWhere((key, value) => value == null);
      //{'User-Type': event.userType}

      final res = await _dio.post(
        url.startsWith('http') ? url : "${await _getBaseUrl()}/$url",
        data: formData == null ? (body ?? {}) : FormData.fromMap(formData),
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            if (headers != null) ...headers,
            if (!removeConstHeaders) ...constHeader,


            if (headers == null && url.contains('provider')) ...{
              'User-Type': 'provider',
            },
          },
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if (res.data is Map) {
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 422,
        errType: ErrorType.unknown,
        msg: kDebugMode
            ? '$e'
            : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  Future<CustomResponse> deleteFromServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? formData,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      body?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      formData?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      final res = await _dio.delete(
        url.startsWith('http') ? url : "${await _getBaseUrl()}/$url",
        data: formData == null ? (body ?? {}) : FormData.fromMap(formData),
        options: Options(
          headers: {if (headers != null) ...headers, ...constHeader},
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if (res.data is Map) {
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 422,
        errType: ErrorType.unknown,
        msg: kDebugMode
            ? '$e'
            : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  Future<CustomResponse> getFromServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool removeConstHeaders = false,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      final res = await _dio.get(
        url.startsWith('http') ? url : "${await _getBaseUrl()}/$url",
        options: Options(
          headers: {
            if (headers != null) ...headers,
            if (!removeConstHeaders) ...constHeader,
            if (headers == null && url.contains('provider')) ...{
              'User-Type': 'provider',
            },

          },
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if (res.data is Map) {
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: ErrorType.unknown,
        msg: kDebugMode
            ? e.toString()
            : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  Future<CustomResponse> putToServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? formData,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      body?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      formData?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      final res = await _dio.put(
        url.startsWith('http') ? url : "${await _getBaseUrl()}/$url",
        data: formData == null ? (body ?? {}) : FormData.fromMap(formData),
        options: Options(
          headers: {if (headers != null) ...headers, ...constHeader},
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if (res.data is Map) {
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 422,
        errType: ErrorType.unknown,
        msg: kDebugMode
            ? '$e'
            : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  Future<CustomResponse> patchToServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? formData,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      body?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      formData?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      final res = await _dio.patch(
        url.startsWith('http') ? url : "${await _getBaseUrl()}/$url",
        data: formData == null ? (body ?? {}) : FormData.fromMap(formData),
        options: Options(
          headers: {if (headers != null) ...headers, ...constHeader},
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if (res.data is Map) {
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 422,
        errType: ErrorType.unknown,
        msg: kDebugMode
            ? '$e'
            : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  //required|string|in:AttributeTemplate,Auction,AuctionBid,AuctionInsuranceTransaction,AuctionLiveMessage,AuctionParticipant,AuctionProduct,AuctionReport,AuctionWinner,AuthVerification,Breed,Breeder,Cart,CartItem,Category,Category,City,Color,Contact,Country,DeliveryAddress,Device,EscrowTransaction,Faq,HealthStatus,Media,NotificationGroup,Order,OrderChat,OrderChatMessage,OrderDeclaration,OrderItem,OrderStatusHistory,Page,Permission,Product,ProductAttribute,ProductMedia,Rating,ReproductiveStatus,ReturnRequest,Role,Setting,ShippingProof,Slider,SubCategory,SubOrder,Trader,User,User,Wallet,WalletTransaction,WithdrawRequest
  Future<String> uploadFile(
    File file, {
    String? attachmentType,
    String? option,
    String? modelType,
    bool isSave = false,
    required String model,
    Function(int, int)? onSendProgress,
  }) async {
    print('-= =--= uploadFile $model $attachmentType $file');
    String fileId = '';
    final map = {
      "file": MultipartFile.fromFileSync(file.path),
      'media_type': attachmentType ?? "image",
      'model': model,
      "option": option,
      "model_type": modelType,
      "is_single": '1',
    };
    log('=-=-==-=--=-==- ${map}');
    final resp = await sendToServer(
      url: 'general/attachment',
      formData: map,
      onSendProgress: onSendProgress,
    );

    if (resp.success) {
      final String? potentialId = resp.data['data']?['id']?.toString();
      fileId = potentialId ?? '';
      if (isSave) {
        UserModel.i.avatar = resp.data['data']?['path'] ?? '';
      }
      // print('-==-=- here ${resp.data['data']}');
      return fileId;
    } else {
      FlashHelper.showToast(resp.msg);
    }
    return fileId;
  }

  CustomResponse<T> handleServerError<T>(DioException err) {
    if (err.type == DioExceptionType.badResponse) {
      if ("${err.response?.data}".isEmpty) {
        return CustomResponse(
          success: false,
          statusCode: 402,
          errType: ErrorType.unknown,
          msg: LocaleKeys.something_went_wrong_please_try_again.tr(),
          data: err.response?.data,
        );
      } else if (err.response!.data.toString().contains("DOCTYPE") ||
          err.response!.data.toString().contains("<script>") ||
          err.response!.data["exception"] != null) {
        return CustomResponse(
          success: false,
          errType: ErrorType.server,
          statusCode: err.response!.statusCode ?? 500,
          msg: kDebugMode
              ? "${err.response!.data}"
              : LocaleKeys.something_went_wrong_please_try_again.tr(),
        );
      } else if (err.response?.statusCode == 401) {
        if (UserModel.i.isAuth) {
          UserModel.i.clear();
          pushAndRemoveUntil(NamedRoutes.login);
        }

        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 401,
          errType: ErrorType.unAuth,
          msg: err.response?.data["message"] ?? '',
          data: err.response?.data,
        );
      } else {
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 500,
          errType: ErrorType.backEndValidation,
          msg: err.response?.data["message"] ?? "",
          data: err.response?.data,
        );
      }
    } else if (err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return CustomResponse(
        success: false,
        statusCode: err.response?.statusCode ?? 500,
        errType: ErrorType.network,
        msg: LocaleKeys.poor_connection_check_the_quality_of_the_internet.tr(),
        data: err.response?.data,
      );
    } else if (err.response == null) {
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: ErrorType.network,
        msg: LocaleKeys.please_check_your_internet_connection.tr(),
        data: err.response?.data,
      );
    } else {
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: ErrorType.unknown,
        msg: LocaleKeys.something_went_wrong_please_try_again.tr(),
        data: err.response?.data,
      );
    }
  }

  Future<String> get baseUrl => _getBaseUrl();

  Future<String> _getBaseUrl() async {
    if (_baseUrl != null) {
      return _baseUrl!;
    } else {
      final res = await _dio.get(
        'https://inaami-default-rtdb.firebaseio.com/base_url.json',
      );
      if (res.statusCode == 200) {
        return _baseUrl = res.data;
      } else {
        throw throw DioException.badResponse(
          statusCode: 422,
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
            data: {'message': 'حدث مشكله بالاتصال بالسيرفر'},
          ),
        );
      }
    }
  }
}

// class CustomApiInterceptor extends Interceptor {
//   final log = LoggerDebug(headColor: LogColors.red, constTitle: "Server Gate Logger");

//   CustomApiInterceptor();

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     log.red("\x1B[37m------ Current Error Response (status code ${err.response?.statusCode}) -----\x1B[0m");
//     log.red("\x1B[31m${jsonEncode(err.response?.data)}\x1B[0m");
//     return super.onError(err, handler);
//   }

//   @override
//   Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
//     log.green("------ Current Response (status code ${response.statusCode}) ------");
//     log.green(jsonEncode(response.data));
//     return super.onResponse(response, handler);
//   }

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     log.yellow("------ Current Request Path -----");
//     log.yellow("${options.path} ${LogColors.red}API METHOD : (${options.method})${LogColors.reset}");
//     if (options.data != null) {
//       log.cyan("------ Current Request body Data -----");
//       if (options.data is FormData) {
//         Map<String, dynamic> body = {};
//         for (var element in (options.data as FormData).fields) {
//           body[element.key] = element.value;
//         }
//         for (var element in (options.data as FormData).files) {
//           body[element.key] = '${element.value.filename}';
//         }

//         log.cyan(jsonEncode(body));
//       } else {
//         log.cyan(jsonEncode(options.data));
//       }
//     }
//     log.white("------ Current Request Parameters Data -----");
//     log.white(jsonEncode(options.queryParameters));
//     log.yellow("------ Current Request Headers -----");
//     log.yellow(jsonEncode(options.headers));
//     return super.onRequest(options, handler);
//   }
// }

class CustomApiInterceptor extends Interceptor {
  final log = LoggerDebug(
    headColor: LogColors.red,
    constTitle: "Server Gate Logger",
  );

  CustomApiInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.red(
      "\x1B[37m------ Current Error Response (status code ${err.response?.statusCode}) -----\x1B[0m",
    );
    log.red(
      jsonEncode(err.response?.data),
      err.response?.requestOptions.path.split('.com/').last,
    );
    log.red(_generateCurlCommand(err.requestOptions));
    return super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    log.green(
      "------ Current Response (status code ${response.statusCode}) ------",
    );
    log.green(
      jsonEncode(response.data),
      response.requestOptions.path.split('.com/').last,
    );
    log.white(_generateCurlCommand(response.requestOptions));
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.yellow("------ Current Request Path -----");
    log.yellow(
      "${options.path} ${LogColors.red}API METHOD : (${options.method})${LogColors.reset}",
    );
    if (options.data != null) {
      log.cyan("------ Current Request body Data -----");
      if (options.data is FormData) {
        Map<String, dynamic> body = {};
        for (var element in (options.data as FormData).fields) {
          body[element.key] = element.value;
        }
        for (var element in (options.data as FormData).files) {
          body[element.key] = '${element.value.filename}';
        }

        log.cyan(jsonEncode(body));
      } else {
        log.cyan(jsonEncode(options.data));
      }
    }
    log.white("------ Current Request Parameters Data -----");
    log.white(jsonEncode(options.queryParameters));
    log.yellow("------ Current Request Headers -----");
    log.yellow(jsonEncode(options.headers));
    return super.onRequest(options, handler);
  }

  String _generateCurlCommand(RequestOptions options) {
    final method = options.method;
    final url = options.uri.toString();
    final headers = options.headers;
    final data = options.data;

    // Start building the cURL command
    final curlCommand = StringBuffer("curl -X $method '$url'");

    // Add headers
    headers.forEach((key, value) {
      curlCommand.write(" -H '$key: $value'");
    });

    // Add body if present
    if (data != null) {
      if (data is FormData) {
        final formDataMap = {
          for (var entry in data.fields) entry.key: entry.value,
          for (var file in data.files) file.key: file.value.filename,
        };
        curlCommand.write(" --data '${jsonEncode(formDataMap)}'");
      } else if (data is Map) {
        curlCommand.write(" --data '${jsonEncode(data)}'");
      } else {
        curlCommand.write(" --data '$data'");
      }
    }

    return curlCommand.toString();
  }
}

class CustomResponse<T> {
  bool success;
  ErrorType errType;
  String msg;
  int statusCode;
  T? data;

  CustomResponse({
    this.success = false,
    this.errType = ErrorType.none,
    this.msg = "",
    this.statusCode = 0,
    this.data,
  });
}
